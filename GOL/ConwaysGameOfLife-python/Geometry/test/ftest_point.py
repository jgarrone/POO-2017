# coding: utf-8
from unittest import TestCase

from Geometry.point import Point

__author__ = 'Andres'


class testPoint(TestCase):
	def testAPointHasEightNeighbors(self):
		aPoint = Point(2, 3)

		neighbors = aPoint.eightNeighbors()

		self.assertTrue(len(neighbors) == 8)

	def testAPointsEightNeighborsAreAlsoPoints(self):
		aPoint = Point(2, 3)

		neighbors = aPoint.eightNeighbors()

		for neighbor in neighbors:
			self.assertIsInstance(neighbor, Point)
