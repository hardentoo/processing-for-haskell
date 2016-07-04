-- | Processing functions.
module Graphics.Proc(
	-- * Structure
	Proc(..), runProc,
	
	-- * Types
	Pio, Draw, Update, TimeInterval, Col(..), P2, P3,

	-- * Environment
	winSize, winWidth, winHeight,
	size,
	smooth, noSmooth, frameCount, frameRate,
	loop, noLoop, redraw,

	-- * Data
	-- | We can use ordinary Haskell datatypes primitive and composite ones.

	-- ** Conversion
	float, int,
	
	-- ** String Functions
	-- | We can use standard Haskell string functions.

	-- ** Array Functions
	--  | We can use Haskell arrays.
	
	-- * Control
	-- | We can use plain old Bool datatype.

	
	-- * Shape

	-- ** 2D Primitives

	triangle, rect, quad, ellipse, circle, line, linePath, point, pointPath, polygon,

	-- ** Curves
	bezier,

	-- ** 3D Primitives

	-- ** Attributes
	EllipseMode, RectMode, DrawMode(..), ellipseMode, rectMode,
	strokeWeight,

	-- ** Vertex

	-- ** Loading & Displaying

	-- * Input

	-- ** Mouse
	mouse, mouseX, mouseY, 
	relMouse, relMouseX, relMouseY,

	-- ** Keyboard
	Key(..), key, Modifiers(..), modifiers, 

	-- ** Files

	-- ** Time & Date
	year, month, day, hour, minute, second, millis, utcHour,

	-- * Output	

	-- ** Text Area
	println,

	-- ** Image
	
	-- ** Files
	
	-- * Transform
	translate, 
	rotate, rotateX, rotateY, rotateZ, 
	scale, 
	resetMatrix, local, 
	applyMatrix, 
	shearX, shearY,

	-- * Lights
	
	-- * Camera

	-- ** Coordinates

    -- ** Material Properties  
	
	-- * Color		
    fill, noFill, stroke, noStroke, strokeFill,
    rgb, rgba, grey, greya, 
	background, clear,

	white, black, green, blue, orange, yellow, red,

	-- * Image	

	-- ** Loading & Displaying

	-- ** Textures

	-- ** Pixels

	-- ** Rendering

	-- ** Shaders

	-- * Typography

	-- ** Loading & Displaying
	-- Font, loadFont, text, textFont,

	-- ** Attributes
	-- textSize,
	
	-- ** Metrics

	-- * Math

	-- ** Operators
	
	-- ** Bitwise Operators
	
	-- ** Calculation
	remap, FloatInterval,
	constrain, constrain2,

	-- ** Trigonometry
	radians, degrees, e, erad,

	-- ** Random
	randomSeed, random, random2, randomP2, randomCol, 
	randomGaussian,

	-- *** Perlin noise
	-- | Returns the Perlin noise value at specified coordinates. Perlin noise is a random sequence generator producing a more natural, harmonic succession of numbers than that of the standard random() function. It was developed by Ken Perlin in the 1980s and has been used in graphical applications to generate procedural textures, shapes, terrains, and other seemingly organic forms.
  	--
  	-- processing docs: <https://processing.org/reference/noise_.html>
	NoiseDetail(..), noiseDetail, noiseOctaves, noiseSeed, noise1, noise2, noise3,
	
	-- * Misc
	onCircle, onLine, uon,

	-- * Pio mutable values
	PioRef, newPioRef, readPioRef, writePioRef, modifyPioRef,

	-- | Useful standard functions
	module Data.VectorSpace,
	module Data.AffineSpace,
	module Data.Cross,	
    module Data.NumInstances,
	module Data.Default,
	module Data.Monoid,
	module Control.Monad,
	module Control.Applicative	
) where

import Data.Default
import Control.Monad
import Control.Applicative
import Data.Monoid

import Data.VectorSpace hiding (Sum(..))
import Data.NumInstances
import Data.AffineSpace
import Data.Cross

import Graphics.Proc.Core
import Graphics.Proc.Lib
