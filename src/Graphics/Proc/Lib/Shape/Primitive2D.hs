module Graphics.Proc.Lib.Shape.Primitive2D(	
	triangle, rect, quad, ellipse, 
	circle, line, linePath,
	point, pointPath, polygon,
) where

import Control.Monad.Trans.State.Strict
import Graphics.Proc.Core
import Graphics.Rendering.OpenGL hiding (get, rect)

triangle :: P2 -> P2 -> P2 -> Draw
triangle p1 p2 p3 = drawProcP2 (Triangles, LineLoop) [p1, p2, p3]    

rect :: P2 -> P2 -> Draw
rect (x, y) (w, h) = drawProcP2 (Polygon, LineLoop) [(x, y), (x, y + h), (x + w, y + h), (x + w, y)]

quad :: P2 -> P2 -> P2 -> P2 -> Draw
quad p1 p2 p3 p4 = drawProcP2 (Polygon, LineLoop) [p1, p2, p3, p4]

polygon :: [P2] -> Draw
polygon ps = drawProcP2 (Polygon, LineLoop) ps

point :: P2 -> Draw
point p = do
  setStrokeColor
  drawP2 Points [p]

pointPath :: [P2] -> Draw
pointPath ps = do
  setStrokeColor
  drawP2 Points ps


setStrokeColor :: Pio ()
setStrokeColor = Pio $ do
  mcol <- fmap globalStroke get
  unPio $ setCol $ maybe defStrokeColor id mcol

line :: P2 -> P2 -> Draw
line p1 p2 = do
  setStrokeColor
  drawP2 Lines [p1, p2]

linePath :: [P2] -> Draw
linePath ps = do
  setStrokeColor
  drawP2 LineStrip ps

ellipse :: P2 -> P2 -> Draw
ellipse center rad = Pio $ do
  mode <- fmap globalEllipseMode get
  unPio $ drawProcP2 (Polygon, LineLoop) (modeEllipsePoints mode 150 rad center) 

circle :: Float -> P2 -> Draw
circle rad center = drawProcP2 (Polygon, LineLoop) (modeEllipsePoints Radius 150 (rad, rad) center) 

modeEllipsePoints mode number (a, b) (c, d) = (uncurry $ ellipsePoints number) $ case mode of
  Center  -> 
    let width = a
        height = b
        cx = c
        cy = d
    in ((width / 2, height / 2), (cx, cy))
  Radius  ->
    let radx = a
        rady = b
        cx = c
        cy = d
    in ((radx, rady), (cx, cy))
  Corner  -> 
    let width = a
        height = b
        px = c
        py = d
        rx = width / 2
        ry = width / 2
    in ((rx, ry), (px + rx, py + ry))
  Corners ->
    let p1x = a
        p1y = b
        p2x = c
        p2y = d
    in ((abs (p1x - p2x) / 2, abs (p1y - p2y) / 2), ((p1x + p2x) / 2, (p1y + p2y) / 2))

ellipsePoints number (radx, rady) (cx, cy) = 
    [ let alpha = twoPi * i /number
      in (cx + radx * (cos (alpha)), cy + rady * (sin (alpha)))
    | i <- [1,2..number]]
    where
        twoPi = 2*pi


---------------------------------------------------

drawP2 primType ps = do   
  liftIO $ renderPrimitive primType $ mapM_ v2 ps

drawProcP2 (onFill, onStroke) ps = Pio $ do
    s <- get    
    maybeDraw onFill   globalFill s    
    maybeDraw onStroke globalStroke s
    where
        maybeDraw shapeType select s = unPio $ maybe (return ()) (go shapeType) $ select s  

        go shapeType col = do            
            setCol col
            drawP2 shapeType ps

defStrokeColor = black
black = Col 0 0 0 1

setCol :: Col -> Draw
setCol col = liftIO $ currentColor $= glCol col
