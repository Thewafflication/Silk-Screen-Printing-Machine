$fn = 100;
use <./modules/hingePairBase.scad>;


mmToIn = 25.4;

module hinge()
{
     hingedPlatePair(plateWidth           = 0.5     * mmToIn, 
                     plateHeight          = 1.5     * mmToIn, 
                     plateThickness       = 0.075   * mmToIn,
                     hingeOutsideDiameter = 0.1875  * mmToIn,
                     hingeInsideDiamter   = 0.125   * mmToIn,
                     hingeSectionCount    = 3);
}
hinge();
