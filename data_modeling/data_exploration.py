# %%
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

# %%
# Import data
airports_df = pd.read_csv('airports.csv')
flights_df = pd.read_csv('flights.csv')
planes_df = pd.read_csv('planes.csv')
weather_df = pd.read_csv('weather.csv')

# %%
# Explore the airports dataset
print(f"Number of rows in airports_df: {len(airports_df)}")
# %%
airports_df.columns
# %%
airports_df.faa.unique
# %%
# Draw a map of the airports to see the country coverage
m = Basemap(width=12000000,height=9000000,projection='lcc',
            resolution=None,lat_1=45.,lat_2=55,lat_0=50,lon_0=-107.)
m.shadedrelief()
x,y =m(airports_df['lon'].values, airports_df['lat'].values)
m.scatter(x,y,s=5,marker='o')
plt.show()
# It appears that the airports metadata are distributed across the US

# Explore the flights dataset
# %%
print(f"Number of rows in flights_df: {len(flights_df)}")
# %%
flights_df.columns
# %%
# %%
print(f"The date range in flights_df: {flights_df['year'].min()} to {flights_df['year'].max()}")
flights_df['origin'].value_counts()
# %%
airports_df.loc[airports_df['faa']=='EWR']
# %%
airports_df.loc[airports_df['faa']=='JFK']
# %%
airports_df.loc[airports_df['faa']=='LGA']
# The origin of the flights data are the 3 NY airports
# %%
flights_df['dest'].value_counts()

# %%
flights_df['flight'].value_counts()
# The primary key on the flights_df appears to be a combination of columns: flight + departure time dimension (+ airline carrier?)
# %%
# Explore the planes dataset
print(f"Number of rows in planes_df: {len(planes_df)}")
# %%
planes_df.columns
# The primary key on the planes_df appears to be tailnum
# %%
# Explore the weather dataset
# %%
print(f"Number of rows in weather_df: {len(weather_df)}")
# %%
weather_df.columns
# The primary key on the weather_df appears to be origin + time dimension


# %%
