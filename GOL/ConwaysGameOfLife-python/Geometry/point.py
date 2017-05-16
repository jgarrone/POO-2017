# coding: utf-8

__author__ = 'Andres'


class Point(object):
	def __init__(self, x, y):
		self._x = x
		self._y = y

	def __eq__(self, other):
		return self._x == other.x() and self._y == other.y()

	def __hash__(self):
		return hash((self._x, self._y))

	def x(self):
		return self._x

	def y(self):
		return self._y

	def eightNeighbors(self):
		leftNeighbors = [Point(self.x()-1, y) for y in range(self.y()-1, self.y()+2)]
		rightNeighbors = [Point(self.x()+1, y) for y in range(self.y()-1, self.y()+2)]
		topNeighbor = [Point(self.x(), self.y()+1)]
		bottomNeighbor = [Point(self.x(), self.y()-1)]

		return leftNeighbors + rightNeighbors + topNeighbor + bottomNeighbor
