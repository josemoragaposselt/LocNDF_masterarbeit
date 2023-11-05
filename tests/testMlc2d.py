"""
set of test to check the input types
"""

import unittest

import numpy as np

import src.loc_ndf.datasets.datasets as DS


class TestMlc2d(unittest.TestCase):
    """
    Test set of functions of MLC2D
    """

    def interpolatePosition(self):
        """
        Interpolate position test
        """
        points = np.array([10.0, 10.0, 10.0])
        center = np.array([0.0, 0.0, 0.0])
        num_of_int_points = 20
        log = False
        truncation_d = None
    
        # default case
        out1 = DS.interpolate_points(points, 
                                     center,
                                     num_of_int_points,
                                     log,
                                     truncation_d)
        print('++++ default output =', out1)
