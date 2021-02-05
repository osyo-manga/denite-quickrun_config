import re

from denite.base.source import Base
from denite.util import relpath, Nvim, UserContext, Candidates

class Source(Base):
	def __init__(self, vim):
		super().__init__(vim)
		self.name = 'quickrun_config'
		self.kind = 'quickrun_config'

	def gather_candidates(self, context):
		candidates = ['apple', 'banana', 'cake']
		filetype = self.vim.eval("&filetype")
		quickrun_config = self.vim.call('denite#quickrun_config#gather_candidates')
		candidates = quickrun_config.keys()
		
		return list(map(lambda candidate: {
			'word': candidate,
			'action__filetype': filetype
			}, candidates))

