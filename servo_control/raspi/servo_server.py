#!/usr/bin/env python3

import datetime
import logging
import os
import select
import serial
import socketserver
import sys
import time

from common import *

SERVER_HOST, SERVER_PORT = '0.0.0.0', PI_PORT

serial_port = None


class MyUDPHandler(socketserver.BaseRequestHandler):

    def handle(self):
        global serial_port
        data = self.request[0].strip()
        socket = self.request[1]
        print("{} wrote:".format(self.client_address[0]))
        print('Data:', data)
        data_decoded = data.decode()
        print('Data decoded:', data_decoded)
    
        if data_decoded in ('U', 'D', 'B', 'E'):
            serial_port.write(data)
        else:
            print('Unknown command: {}'.format(data_decoded))


class MyServer(socketserver.UDPServer):

    def __init__(self, server_address, handler_class=MyUDPHandler):
        socketserver.UDPServer.__init__(self, server_address, handler_class)


    def server_activate(self):
        socketserver.UDPServer.server_activate(self)


    def handle_request(self):
        return socketserver.UDPServer.handle_request(self)


def init_serial():
    global serial_port
    serial_port = serial.Serial('/dev/ttyUSB0', 115200)


def main():
    logging.basicConfig(filename=LOG_FILENAME, format='%(asctime)s %(levelname)s:%(message)s', level=logging.DEBUG)

    init_serial()

    server = MyServer((SERVER_HOST, SERVER_PORT), MyUDPHandler)

    while True:
        # this is relict from having second Arduino connected to the serial port
        input_ready, output_ready, except_ready = select.select([server], [], [])
        for s in input_ready:
            if s is server:
                logging.info('Receiving data on UDP server...')
                s.handle_request()


if __name__ == '__main__':
    main()
