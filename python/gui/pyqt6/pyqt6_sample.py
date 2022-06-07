#!/usr/bin/env python

import sys
from PyQt6.QtWidgets import QApplication,QMainWindow,QWidget,QPushButton,QHBoxLayout,QVBoxLayout,QTabWidget,QGridLayout
from PyQt6.QtGui import QAction

#class App(QWidget):
class App(QMainWindow):
	def __init__(self):
		super().__init__()
		self.setWindowTitle('PyQt6 GUI Sample')
		#self.setGeometry(100,100,200,150)
		self.resize(200,150)

		# ----- MenuBar ----
		menubar = self.menuBar()
		mnu_file = menubar.addMenu('&File')
		mnu_file.addAction(QAction('&New', self, triggered=self.newFile))

		mnu_edit = menubar.addMenu('&Edit')
		mnu_edit.addAction(QAction('&Edit', self, triggered=self.editFile))

		mnu_help = menubar.addMenu('&Help')
		# a menu ('Help') is not shown in case that it has only 'About' sub menu (?)
		mnu_help.addAction(QAction('&About', self, triggered=self.helpAction))
		mnu_help.addAction(QAction('&OkOk', self, triggered=self.helpAction))

		mnu_omake = menubar.addMenu('&Omake')
		mnu_omake.addAction(QAction('&Kamon', self, triggered=self.helpAction))


		# ----- Tab --------
		#tab = QTabWidget(self)
		tab = QTabWidget()
		self.setCentralWidget(tab)

		# ----- Tab1 -------
		widget1 = QWidget()
		tab.addTab(widget1, 'Tab1')

		layout_h = QHBoxLayout()
		#self.setLayout(layout_h)
		widget1.setLayout(layout_h)

		layout_v1 = QVBoxLayout()
		layout_h.addLayout(layout_v1)

		layout_v2 = QVBoxLayout()
		layout_h.addLayout(layout_v2)

		button = QPushButton('OK', self)
		button.clicked.connect(self.terminate) # when clicked
		#button.pressed.connect(self.terminate) # when pushed
		#button.released.connect(self.terminate) # when released
		layout_v1.addWidget(button)

		layout_v1.addWidget(QPushButton('Btn12'))

		layout_v2.addWidget(QPushButton('Btn21'))
		layout_v2.addWidget(QPushButton('Btn22'))
		layout_v2.addWidget(QPushButton('Btn23'))

		# ----- Tab2 -------
		widget2 = QWidget()
		tab.addTab(widget2, 'Tab2')

		layout_g = QGridLayout()
		widget2.setLayout(layout_g)

		layout_g.addWidget(QPushButton('B11'), 0, 0)
		layout_g.addWidget(QPushButton('B12'), 0, 1)
		layout_g.addWidget(QPushButton('B21'), 1, 0)
		layout_g.addWidget(QPushButton('B22'), 1, 1)

	def terminate(self):
		print('Terminated!')
		self.close()

	def newFile(self):
		print('File->New')

	def editFile(self):
		print('Edit->Edit')

	def helpAction(self):
		print('Help')

qapp = QApplication(sys.argv)
app = App()
app.show()
qapp.exec()
