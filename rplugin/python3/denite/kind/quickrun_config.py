# FILE: sample.py
# AUTHOR: xxx <xxx.yyy.zzz@gmail.com>
# License: MIT license

from .base import Base
from denite.util import relpath, Nvim, UserContext, Candidates


class Kind(Base):
	def __init__(self, vim):
		super().__init__(vim)
		self.name = 'quickrun_config'
		self.default_action = 'set_local_quickrun_config'

	def action_set_local_quickrun_config(self, context):
		self.vim.call("denite#quickrun_config#set_local_quickrun_config", context)

