# -*- coding: utf-8 -*-

"""
***************************************************************************
    MessageBarProgress.py
    ---------------------
    Date                 : April 2013
    Copyright            : (C) 2013 by Victor Olaya
    Email                : volayaf at gmail dot com
***************************************************************************
*                                                                         *
*   This program is free software; you can redistribute it and/or modify  *
*   it under the terms of the GNU General Public License as published by  *
*   the Free Software Foundation; either version 2 of the License, or     *
*   (at your option) any later version.                                   *
*                                                                         *
***************************************************************************
"""
from builtins import object


__author__ = 'Victor Olaya'
__date__ = 'April 2013'
__copyright__ = '(C) 2013, Victor Olaya'

# This will get replaced with a git SHA1 when you do a git archive

__revision__ = '$Format:%H$'

from qgis.PyQt.QtCore import Qt, QCoreApplication
from qgis.PyQt.QtWidgets import QProgressBar
from qgis.utils import iface
from processing.gui.MessageDialog import MessageDialog


class MessageBarProgress(object):

    def __init__(self, algname=None):
        self.msg = []
        self.progressMessageBar = \
            iface.messageBar().createMessage(self.tr('Executing algorithm <i>{0}</i>'.format(algname if algname else '')))
        self.progress = QProgressBar()
        self.progress.setMaximum(100)
        self.progress.setAlignment(Qt.AlignLeft | Qt.AlignVCenter)
        self.progressMessageBar.layout().addWidget(self.progress)
        iface.messageBar().pushWidget(self.progressMessageBar,
                                      iface.messageBar().INFO)

    def error(self, msg):
        self.msg.append(msg)

    def setText(self, text):
        pass

    def setPercentage(self, i):
        self.progress.setValue(i)

    def setInfo(self, _):
        pass

    def setCommand(self, _):
        pass

    def setDebugInfo(self, _):
        pass

    def setConsoleInfo(self, _):
        pass

    def close(self):
        if self.msg:
            dlg = MessageDialog()
            dlg.setTitle(QCoreApplication.translate('MessageBarProgress', 'Problem executing algorithm'))
            dlg.setMessage("<br>".join(self.msg))
            dlg.exec_()
        iface.messageBar().clearWidgets()

    def tr(self, string, context=''):
        if context == '':
            context = 'MessageBarProgress'
        return QCoreApplication.translate(context, string)
