# -*- coding: utf-8 -*-
"""
Created on Mon Nov 30 16:33:10 2020

@author: matheus
"""

import matplotlib.pyplot as plt
import numpy as np
# pacotes relacionados às funcionalidades do cartopy
import cartopy.crs as ccrs
import cartopy.feature as cfeature
import shapely.geometry as sgeom


lower = [-60, -90]
upper = [15, -25]
extent = [lower[1], upper[1], lower[0], upper[0]]

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
        'fontsize': 14,
        'weight':'bold'
    }

    gl.ylabel_style = dict_style_labels
    gl.xlabel_style = dict_style_labels
    
def configuring_map2(ax, extent):

    gl = ax.gridlines(crs=ccrs.PlateCarree(), draw_labels=True,
                      linewidth=.8, color='gray', 
                      alpha=0.5, linestyle='--',
                      xlocs=np.linspace(-41.5, -38.5, 3),
                      ylocs=np.linspace(-18.5, -21, 3))

    gl.top_labels = False
    gl.left_labels = False

    # dicionario com configurações dos rótulos
    dict_style_labels = {
        'color': 'black',
        'fontsize': 20,
        'weight':'bold'
    }

    gl.ylabel_style = dict_style_labels
    gl.xlabel_style = dict_style_labels


def make_map(fig=None, ax=None, extent=[-50,-41,-30,-22], projection=ccrs.PlateCarree()):
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
    
    states_10m = cfeature.STATES.with_scale('50m')
    country_10m = cfeature.BORDERS.with_scale('50m')
    # inserting information over the map
    ax.add_feature(coastline_10m, 
                   edgecolor='black',
                   linewidth=.3)
    ax.add_feature(bathy_0m,
                   facecolor='lightblue',
                   alpha=.3)
    ax.add_feature(land_0m)
    
    ax.add_feature(states_10m, edgecolor='black',
                   linewidth=.3)
    ax.add_feature(country_10m,
                   edgecolor='grey',
                   linewidth=.3)
    
    return ax

def make_map2(fig=None, ax=None, extent=[-50,-41,-30,-22], projection=ccrs.PlateCarree()):
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
    
    states_10m = cfeature.STATES.with_scale('10m')
    # country_10m = cfeature.BORDERS.with_scale('50m')
    # inserting information over the map

    ax.add_feature(bathy_0m,
                    facecolor='lightblue',
                    alpha=.3)


    ax.add_feature(land_0m)
    
    ax.add_feature(states_10m, edgecolor='black',
                   linewidth=.5)
    
    return ax

def scale_bar(ax, length=None, location=(0.5, 0.05), linewidth=5):
    """
    ax is the axes to draw the scalebar on.
    length is the length of the scalebar in km.
    location is center of the scalebar in axis coordinates.
    (ie. 0.5 is the middle of the plot)
    linewidth is the thickness of the scalebar.
    """
    #Get the limits of the axis in lat long
    llx0, llx1, lly0, lly1 = ax.get_extent(ccrs.PlateCarree())
    #Make tmc horizontally centred on the middle of the map,
    #vertically at scale bar location
    sbllx = (llx1 + llx0) / 2
    sblly = lly0 + (lly1 - lly0) * location[1]
    tmc = ccrs.TransverseMercator(sbllx, sblly)
    #Get the extent of the plotted area in coordinates in metres
    x0, x1, y0, y1 = ax.get_extent(tmc)
    #Turn the specified scalebar location into coordinates in metres
    sbx = x0 + (x1 - x0) * location[0]
    sby = y0 + (y1 - y0) * location[1]

    #Calculate a scale bar length if none has been given
    #(Theres probably a more pythonic way of rounding the number but this works)
    if not length: 
        length = (x1 - x0) / 5000 #in km
        ndim = int(np.floor(np.log10(length))) #number of digits in number
        length = round(length, -ndim) #round to 1sf
        #Returns numbers starting with the list
        def scale_number(x):
            if str(x)[0] in ['1', '2', '5']: return int(x)        
            else: return scale_number(x - 10 ** ndim)
        length = scale_number(length) 

    #Generate the x coordinate for the ends of the scalebar
    bar_xs = [sbx - length * 500, sbx + length * 500]
    #Plot the scalebar
    ax.plot(bar_xs, [sby, sby], transform=tmc, color='k', linewidth=linewidth)
    #Plot the scalebar label
    ax.text(sbx, sby, str(length) + ' km', transform=tmc,
            horizontalalignment='center', verticalalignment='bottom',FontSize=22)

def criando_mapa(extent):
    # coordenadas geográficas do limite do minimapa
    lower = [-21.356, -41.6930]
    upper = [-18.105, -38.2250]
    extent_UC = [lower[1], upper[1], lower[0], upper[0]]

    #criando um polígono
    extent_box = sgeom.box(extent_UC[0], extent_UC[2], extent_UC[1], extent_UC[3])
    # extent_box = sgeom.LineString(zip(lon3,lat3))
    
    # plotando mapa
    fig = plt.figure(figsize=(20/2.54,25/2.54))
    ax = fig.add_subplot(1, 1, 1, projection=ccrs.PlateCarree())
    ax = make_map(fig=fig, ax=ax, extent=extent, projection=ccrs.PlateCarree())
    configuring_map(ax, extent)

    _ = ax.add_geometries([extent_box], ccrs.PlateCarree(), 
                          facecolor='coral', # cor do polígono
                          edgecolor='red',   # cor das arestas
                          alpha=.6)          # transparência

    # setting axes position and size
    left,bottom   = 1.1, 0.150
    width, height  = 1, 0.7
    rect = [left,bottom,width,height]

    # creating axes 2 for minimap
    ax2 = plt.axes(rect, projection=ccrs.PlateCarree())
    ax2 = make_map2(fig=fig, ax=ax2, extent=extent_UC)
    configuring_map2(ax2, extent_UC)
    scale_bar(ax2, 50)
    return fig,ax,ax2

fig,ax,ax2 = criando_mapa(extent)

