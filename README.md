# Thermal Analysis of Aluminum Rod Using Matlab
> OBJECTIVES

Observe and measure thermal waves in an aluminum rod by modulating the heating at one end. 

Compare experimental data with the expected values determined by the simulation:
From matching the simulation graph to the experimental, extract the thermal conductivity, specific heat capacity, and emissivity of the aluminum rod, as well as the fraction of power.

> EXPERIMENTAL SETUP

<p align="center">
<img src="https://lh6.googleusercontent.com/WuYBAhB2sWlDFbBJWcjzhuSgp3mhWZHDXcnnrdEQI_qkeIaL0IcEhODpQ5mx-w3bNwY0doWz9l1yxJCAqvyxRyhmM-crgzcOzjUA5pEehHru2Dn8rZgoPJqP4DAIoxRnT70Pa_rA">
</p>

*Fig 1. Experimental setup to detect diffusive heat waves for aluminum rod. Five 4.58 mm diameter holes were drilled into the rod at approximately even intervals to accommodate the TMP35G sensors. A LT0 100 power resistor was snugly placed onto one face. The same rod is used throughout the experiment.*

> CIRCUIT SETUP

<p align="center">
<img src="https://lh3.googleusercontent.com/RDD8FzDHESsiqw54MK9FLQvV7StCunFBpyZGJ9Wh3UKMauIP6m4-2krP6NaKd4GDMQxok1QcKkmS1YjFPULLYDtBvTjurYfypfV54LVBOehPNo6JU-Rz3QkE04X3hAqeVJQ2SVi2">
</p>

*Fig 2. Circuit diagram shows the electronics used to measure the temperature along the rod. Temperature sensors are each connected to an analog input on the Arduino microcontroller. The Arduino  provides both a common VCC and GND rail, as well as a 3.3V reference voltage that determines the resolution of the temperature measurements.*

> DATA VERIFICATION

The required data to gather from this experiment include: 
- [x] Thermal Conductivity k (W/mK)
- [x] Specific Heat Capacity Cp (J/kgK)
- [x] Power Input P (W)
- [x] Fraction of Power(%)
- [x] Emissivity of Al Rod e
- [x] Convectivity Coefficient kc (W/m^2K)

This Program does not include a chi-squared test, as the plot of data set (gathered from communication with Arduino Uno) can obviously fit on the simulation by changing the above listed variables. 
