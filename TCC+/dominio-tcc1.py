import matplotlib.pyplot as plt
import numpy as np
# pacotes relacionados às funcionalidades do cartopy
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import shapely.geometry as sgeom
from cartopy.mpl.gridliner import LONGITUDE_FORMATTER, LATITUDE_FORMATTER


extent=[-50,-41,-30,-22]
##### TESTE ######
# plt.figure(figsize=(3, 3))
# ax = plt.axes(projection=ccrs.Orthographic(central_longitude=-45, central_latitude=-20))

# gl1 = ax.gridlines(draw_labels=True)


# coastline_10m = cfeature.NaturalEarthFeature(
#      category='physical',name='coastline',scale='10m',
#      facecolor=cfeature.COLORS['land'])

# bathy_0m      = cfeature.NaturalEarthFeature(
#         category='physical',name='bathymetry_L_0',scale='10m')

# land_0m       = cfeature.NaturalEarthFeature(
#         category='physical', name='land', scale='10m',
#         facecolor=cfeature.COLORS['land'] )



# ax.add_feature(coastline_10m, 
#                edgecolor='black',
#                linewidth=.1)

# ax.add_feature(bathy_0m,
#                    facecolor='lightblue',
#                    alpha=.3)
# ax.add_feature(land_0m)
###################

def configuring_map(ax, extent):
    gl = ax.gridlines(crs=ccrs.PlateCarree(), draw_labels=True,
                      linewidth=.8, color='gray', 
                      alpha=0.5, linestyle='--', 
                      xlocs=np.linspace(extent[0], extent[1], 5),
                      ylocs=np.linspace(extent[3], extent[2], 5))

    gl.top_labels = False
    gl.right_labels = False

    # dicionario com configurações dos rótulos
    dict_style_labels = {
        'color': 'black',
        'fontsize': 8,
        'rotation': 35,
        'weight':'bold'
    }

    gl.ylabel_style = dict_style_labels
    gl.xlabel_style = dict_style_labels

def make_map(fig=None, ax=None, extent=[-50,-41,-30,-22], projection=ccrs.Orthographic(central_longitude=-45, central_latitude=-20)):
    """ 

    """
    ax.set_extent(extent, crs=ccrs.PlateCarree())

    coastline_10m = cfeature.NaturalEarthFeature(
        category='physical',name='coastline',scale='10m',
        facecolor=cfeature.COLORS['land'])

    bathy_0m      = cfeature.NaturalEarthFeature(
        category='physical',name='bathymetry_L_0',scale='10m')
    
    land_0m       = cfeature.NaturalEarthFeature(
        category='physical', name='land', scale='10m',
        facecolor=cfeature.COLORS['land'] )
    
    # states_10m = cfeature.STATES.with_scale('50m')
    country_10m = cfeature.BORDERS.with_scale('50m')
    # inserting information over the map
    ax.add_feature(coastline_10m, 
                   edgecolor='black',
                   linewidth=.3)
    ax.add_feature(bathy_0m,
                   facecolor='lightblue',
                   alpha=.3)
    ax.add_feature(land_0m)
    
    # ax.add_feature(states_10m)
    ax.add_feature(country_10m, edgecolor='grey',
                   linewidth=.3)
    
    return ax

def make_map2(fig=None, ax=None, projection=ccrs.Orthographic(central_longitude=-45, central_latitude=-20)):
    """ 

    """
    coastline_10m = cfeature.NaturalEarthFeature(
        category='physical',name='coastline',scale='10m',
        facecolor=cfeature.COLORS['land'])

    bathy_0m      = cfeature.NaturalEarthFeature(
        category='physical',name='bathymetry_L_0',scale='10m')
    
    land_0m       = cfeature.NaturalEarthFeature(
        category='physical', name='land', scale='10m',
        facecolor=cfeature.COLORS['land'] )

    # inserting information over the map
    ax.add_feature(coastline_10m, 
                   edgecolor='black',
                   linewidth=.1)
    ax.add_feature(bathy_0m,
                   facecolor='lightblue',
                   alpha=.3)
    ax.add_feature(land_0m)
    
    return ax

def criando_mapa(extent):
    # coordenadas geográficas do limite do minimapa
    lower = [-60, -90]
    upper = [15, -25]
    extent_UC = [lower[1], upper[1], lower[0], upper[0]]
    
    # lons = [upper[1],lower[1]]
    # lats = [upper[0],lower[0]]
    
    lat1 = list(np.linspace(15, -60, 100))
    lat12 = list(np.linspace(-60, -60, 100))
    lat2 = list(np.linspace(-60, 15, 100))
    lat22 = list(np.linspace(15, 15, 100))
    lat3 = lat1 + lat12 + lat2 + lat22
    lon1 = list(np.linspace(-90, -90, 100))
    lon12 = list(np.linspace(-90, -25, 100))
    lon2 = list(np.linspace(-25, -25, 100))
    lon22 = list(np.linspace(-25, -90, 100))
    lon3 = lon1 + lon12 + lon2 + lon22
    

    # extent_box = sgeom.LineString(extent_UC[0], extent_UC[2], extent_UC[1], extent_UC[3])
    extent_box = sgeom.LineString(zip(lon3,lat3))
    
    # plotando mapa
    fig = plt.figure(figsize=(15/2.54,20/2.54))
    ax = fig.add_subplot(1, 1, 1, projection=ccrs.Orthographic(central_longitude=-45, central_latitude=-20))
    ax = make_map2(fig=fig, ax=ax, projection=ccrs.Orthographic(central_longitude=-45, central_latitude=-20))
    gl1 = ax.gridlines()

    _ = ax.add_geometries([extent_box], ccrs.PlateCarree(), 
                          facecolor='coral', # cor do polígono
                          edgecolor='red',   # cor das arestas
                          alpha=.3)          # transparência

    # setting axes position and size
    left,bottom   = 0.77, 0.167
    width, height  = 0.85, 0.35
    rect = [left,bottom,width,height]

    # creating axes 2 for minimap
    ax2 = plt.axes(rect, projection=ccrs.PlateCarree())
    ax2 = make_map(fig=fig, ax=ax2, extent=extent_UC)
    configuring_map(ax2, extent_UC)
    return fig,ax,ax2

fig,ax,ax2 = criando_mapa(extent)


