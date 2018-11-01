from django.shortcuts import render
from django.http import HttpResponse

import socket


def controller(request):
    return render(request, 'web/controller.html', {})


def send_udp_message(msg):
    HOST = '127.0.0.1'    # The remote host
    PORT = 11111          # The same port as used by the server
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
        sent = s.sendto(msg, (HOST, PORT))

def up(request):
    send_udp_message(b'U')
    return HttpResponse('Up')

def down(request):
    send_udp_message(b'D')
    return HttpResponse('Down')

def back(request):
    send_udp_message(b'B')
    return HttpResponse('Back')

def enter(request):
    send_udp_message(b'E')
    return HttpResponse('Enter')
