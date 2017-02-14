# Open Boiler Control
Modest attempt to control home brown coal boiler

# Goals
This is my attemt to implement controlling software for my home brown coal boiler
that is currently controlled by the Siemens Climatix PLC. The new controller has to
be able to:

* Control ventilator power
* Control coal feeder motor
* Monitor all temperatures and run boiler at optimal operating temeratures

## Monitored Temperatures

* Outside temperature
* Boiler temperature (water temperature in the boiler)
* Exhausts temperature
* Heating circuit temperature (hot water to radiators)
* Heating circuit return (cold water from radiators)
* Hot water cylinder temperature
