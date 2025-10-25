# Supplementary File S1
# Title: Hourly Temperature and Relative Humidity Generation from Monthly Data
# Station: Bauchi, Nigeria
# Author: Dr. Ibrahim Hassan Kobe
# Affiliation: Faculty of Engineering and Technology, University of Ilorin
# Description:
# This script demonstrates the transformation of raw monthly mean and range values
# into continuous hourly temperature and relative humidity (RH) using Fourier synthesis.
# It serves as a reproducibility file for the climatic validation model discussed in the manuscript.

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# ------------------------------------------------------------
# 1. Input: Monthly average and range data (2005–2019 mean)
# ------------------------------------------------------------

months = np.arange(1, 13)
month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
               "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

# Example representative data (replace with ERA5 or measured station data)
monthly_mean_temp = np.array([24.2, 26.1, 28.5, 30.4, 30.7, 29.1, 27.2, 26.8, 27.9, 28.3, 26.0, 24.1])
monthly_range_temp = np.array([8.2, 9.1, 10.3, 11.5, 10.9, 9.6, 8.8, 8.1, 8.9, 9.5, 8.7, 8.0])

monthly_mean_rh = np.array([28.0, 25.5, 24.3, 32.2, 45.6, 63.3, 75.8, 78.2, 69.0, 52.4, 38.5, 31.2])
monthly_range_rh = np.array([12.1, 10.8, 11.2, 15.3, 18.5, 20.4, 21.8, 19.9, 17.5, 15.1, 13.6, 12.0])

# ------------------------------------------------------------
# 2. Fourier Synthesis Model for Hourly Profile Reconstruction
# ------------------------------------------------------------

def fourier_reconstruct(mean_values, n_harmonics=4, hours=24):
    """
    Reconstruct hourly variations using truncated Fourier series.
    """
    t = np.arange(hours)
    N = len(mean_values)
    k = np.arange(N)

    # Discrete Fourier Transform coefficients
    a0 = np.mean(mean_values)
    an = []
    bn = []
    for n in range(1, n_harmonics + 1):
        an.append((2/N) * np.sum(mean_values * np.cos(2*np.pi*n*k/N)))
        bn.append((2/N) * np.sum(mean_values * np.sin(2*np.pi*n*k/N)))

    # Hourly synthesis
    y = np.zeros_like(t, dtype=float)
    for n in range(1, n_harmonics + 1):
        y += an[n-1]*np.cos(2*np.pi*n*t/hours) + bn[n-1]*np.sin(2*np.pi*n*t/hours)
    y = a0 + y
    return y

# ------------------------------------------------------------
# 3. Apply reconstruction to Temperature and Relative Humidity
# ------------------------------------------------------------

hourly_temp = fourier_reconstruct(monthly_mean_temp)
hourly_rh = fourier_reconstruct(monthly_mean_rh)

# Optional: Apply day–night correction using monthly range
hourly_temp_adjusted = hourly_temp + (monthly_range_temp.mean()/2) * np.sin(2*np.pi*np.arange(24)/24 - np.pi/2)
hourly_rh_adjusted = hourly_rh - (monthly_range_rh.mean()/2) * np.sin(2*np.pi*np.arange(24)/24 - np.pi/2)

# ------------------------------------------------------------
# 4. Compile results into a DataFrame and save as CSV
# ------------------------------------------------------------

df_hourly = pd.DataFrame({
    "Hour": np.arange(1, 25),
    "Temperature (°C)": np.round(hourly_temp_adjusted, 2),
    "Relative Humidity (%)": np.round(hourly_rh_adjusted, 2)
})

df_hourly.to_csv("bauchi_hourly_temp_rh.csv", index=False)
print("Hourly data saved to 'bauchi_hourly_temp_rh.csv'.")

# ------------------------------------------------------------
# 5. Visualization
# ------------------------------------------------------------

plt.figure(figsize=(10, 6))
plt.plot(df_hourly["Hour"], df_hourly["Temperature (°C)"], 'r-o', label="Temperature")
plt.plot(df_hourly["Hour"], df_hourly["Relative Humidity (%)"], 'b-s', label="Relative Humidity")
plt.title("Reconstructed Hourly Temperature and RH – Bauchi Station")
plt.xlabel("Hour of Day")
plt.ylabel("Value")
plt.grid(True, linestyle="--", alpha=0.6)
plt.legend()
plt.tight_layout()
plt.show()

# ------------------------------------------------------------
# 6. Output Summary
# ------------------------------------------------------------
print("\nSummary of Generated Hourly Climate Data for Bauchi:")
print(df_hourly.describe().round(2))
