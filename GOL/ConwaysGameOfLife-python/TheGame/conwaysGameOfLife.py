# coding: utf-8
from Geometry.point import Point

__author__ = 'Andres'


class ConwaysGameOfLife(object):
	def __init__(self, anArrayOfPointsIndicatingAliveCells):
		assert isinstance(anArrayOfPointsIndicatingAliveCells, list)
		for point in anArrayOfPointsIndicatingAliveCells:
			assert isinstance(point, Point)

		self._aliveCells = anArrayOfPointsIndicatingAliveCells

	def nextGeneration(self):
		self._aliveCells = self._aliveCellsInNextGenerationFromSecondRule() + \
						   self._aliveCellsInNextGenerationFromFourthRule()

	def _aliveCellsInNextGenerationFromSecondRule(self):
		aliveCells = []
		for cell in self._aliveCells:
			neighborsCount = 0
			aCellsNeighbors = cell.eightNeighbors()
			for anotherCell in self._aliveCells:
				if anotherCell in aCellsNeighbors:
					neighborsCount += 1
			if 2 <= neighborsCount <= 3:
				aliveCells.append(cell)

		return aliveCells

	def _aliveCellsInNextGenerationFromFourthRule(self):
		aliveCells = []
		deadCellsWithNeighbors = {}
		for cell in self._aliveCells:
			for neighbor in cell.eightNeighbors():
				if neighbor not in self._aliveCells:
					if neighbor in deadCellsWithNeighbors:
						deadCellsWithNeighbors[neighbor] += 1
					else:
						deadCellsWithNeighbors[neighbor] = 1

		for deadCell in deadCellsWithNeighbors:
			if deadCellsWithNeighbors[deadCell] == 3:
				aliveCells.append(deadCell)
		return aliveCells

	def isAlive(self, aPoint):
		assert isinstance(aPoint, Point)
		return aPoint in self._aliveCells
