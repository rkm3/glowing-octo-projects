# First we pull in the standard API hooks.
require 'sketchup.rb'

# Show the Ruby Console at startup so we can
# see any programming errors we may make.
Sketchup.send_action "showRubyPanel:"

PI = 3.14159

def rad2deg(theta)
  1.0 * theta * 180 / PI
end

def deg2rad(theta)
  1.0 * theta / 180 * PI
end

def rotate90 theta
  theta + 270
end

def polar2cartesian_rad(r, theta, phi)
  x = r * Math.sin(theta) * Math.cos(phi)
  y = r * Math.sin(theta) * Math.sin(phi)
  z = r * Math.cos(theta)
  [x,y,z]
end

def polar2cartesian(r, theta, phi)
  polar2cartesian_rad(r, deg2rad(theta), deg2rad(phi))
end

def polar2cartesian(r, theta, phi)
  polar2cartesian_rad(r, deg2rad(theta), deg2rad(rotate90 phi))
end

def cartesian2polar(v)
  x,y,z = v
  r = Math.sqrt(x**2 + y**2 + z**2)
  return {:r => 0, :theta => 0, :phi => 0} unless r>0
  theta = Math.acos(z / r)
  phi = Math.atan2(y,x)
  {:r => r, :theta => rad2deg(theta), :phi => rad2deg(phi)}
end

# verification
rad2deg(2*PI) == 360.0
rad2deg(PI)   == 180.0
rad2deg(PI/2) == 90.0
rad2deg(PI/4) == 45.0

deg2rad(360) == 2*PI
deg2rad(180) == PI
deg2rad(90)  == PI/2
deg2rad(45)  == PI/4

cartesian2polar polar2cartesian(100, 45, 45)
cartesian2polar polar2cartesian(100, 45, 90)
cartesian2polar polar2cartesian(100, 23, 12)
cartesian2polar polar2cartesian(100, 180, 12)

#################################################################
#################################################################
#################################################################
#################################################################
#################################################################

# Get handles to our model and the Entities collection it contains.
model = Sketchup.active_model
entities = model.entities

points =  [[0,0,0],[1,1,1],[2,2,2] ]

for p in 1..points.length-1
  new_face = entities.add_face points
end

#################################################################
#################################################################
#################################################################
#################################################################
#################################################################

model = Sketchup.active_model
entities = model.active_entities

#exmaple to make sure functions are working
entities.add_line [0,0,0], polar2cartesian(100, 45, 0)
entities.add_line [0,0,0], polar2cartesian(100, 45, 45)
entities.add_line [0,0,0], polar2cartesian(100, 45, 90)

for x in 1..10
  for i in 1..45
    entities.add_line [x**3,x**2,x], polar2cartesian(100, i, 0)
  end
end

#################################################################
#################################################################
#################################################################
#################################################################
#################################################################

# Draw a cube
model = Sketchup.active_model
entities = model.active_entities

entities.add_line [0,0,10], [10,0,10]
entities.add_line [10,0,10], [10,10,10]
entities.add_line [10,10,10], [0,10,10]
entities.add_line [0,10,10], [0,0,10]

entities.add_line [0,0,0], [10,0,0]
entities.add_line [10,0,0], [10,10,0]
entities.add_line [10,10,0], [0,10,0]
entities.add_line [0,10,0], [0,0,0]

entities.add_line [0,0,0], [0,0,10]
entities.add_line [10,10,0], [10,10,10]
entities.add_line [0,10,0], [0,10,10]
entities.add_line [10,0,0], [10,0,10]

#################################################################
#################################################################
#################################################################
#################################################################
##########################
#draw a polar cube
model = Sketchup.active_model
entities = model.active_entities

cartesian2polar [0,0,0]
cartesian2polar [0,0,10]
cartesian2polar [0,10,0]
cartesian2polar [10,0,0]
cartesian2polar [0,10,10]
cartesian2polar [10,0,10]
cartesian2polar [10,10,0]
cartesian2polar [10,10,10]

entities.add_line polar2cartesian(17, 54, 45), polar2cartesian(14, 90, 45)
entities.add_line polar2cartesian(17, 54, 45), polar2cartesian(14, 45, 0)
entities.add_line polar2cartesian(17, 54, 45), polar2cartesian(14, 45, 90)
entities.add_line polar2cartesian(14, 45, 90), polar2cartesian(10, 90, 90)
entities.add_line polar2cartesian(14, 45, 0),  polar2cartesian(10, 90, 0)
entities.add_line polar2cartesian(10, 90, 0),  polar2cartesian(0, 0, 0)
entities.add_line polar2cartesian(0, 0, 0),    polar2cartesian(10, 90, 90)
