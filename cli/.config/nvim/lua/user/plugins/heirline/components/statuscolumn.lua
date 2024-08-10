local M = {}

local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

-- TODO click handlers
-- TODO helper utility to show specific extmark signs

M.lnum = { provider = '%=%{v:lnum} ' }
M.relnum = { provider = '%=%{v:relnum} ' }

M.folds = {
  fallthrough = false,
  init = function (self)
    self.foldlevel = vim.fn.foldlevel(vim.v.lnum)
    self.foldlevel_before = vim.fn.foldlevel((vim.v.lnum > 1) and (vim.v.lnum - 1) or 1)
    local maxline = vim.fn.line('$')
    self.foldlevel_after = vim.fn.foldlevel((vim.v.lnum < maxline) and (vim.v.lnum + 1 ) or maxline)
    self.foldclosed = vim.fn.foldclosed(vim.v.lnum)
  end,
  {
    condition = function (self)
      return self.foldlevel == 0
    end,
    provider = ' ',
  }, {
    condition = function (self)
      return self.foldclosed > 0 and self.foldclosed == vim.v.lnum
    end,
    provider = '',
  }, {
    condition = function (self)
      return self.foldlevel > self.foldlevel_before and self.foldlevel <= self.foldlevel_after
    end,
    provider = '',
  }, {
    condition = function (self)
      return self.foldlevel > self.foldlevel_after and self.foldlevel <= self.foldlevel_before
    end,
    provider = '╰',
  }, {
    provider = '│',
  },
  hl = 'FoldColumn',
}

local function signs_from_namespace(namespace)
  return {
    static = {
      namespace = namespace,
      namespace_id = nil,
      exmarks = {{ -1, -1, -1, { sign_text = '', sign_hl_group = 'SignColumn' }}},
    },
    init = function (self)
      for name, namespace_id in pairs(vim.api.nvim_get_namespaces()) do
        if string.match(name, self.namespace) then
          self.namespace_id = namespace_id
          break
        end
      end
      if self.namespace_id then
        self.exmarks = vim.api.nvim_buf_get_extmarks(0, self.namespace_id, { vim.v.lnum - 1, 0 }, { vim.v.lnum - 1, -1 }, { type = 'sign', details = true })
      end
    end,
  }
end

M.gitsigns = utils.insert(signs_from_namespace('gitsigns_signs'), {
  {
    fallthrough = false,
    {
      condition = function (self)
        return conditions.is_git_repo() and #self.exmarks > 0
      end,
      provider = function (self)
        return string.format('%s ', self.exmarks[1][4].sign_text:gsub('%s+', ''))
      end,
      hl = function (self)
        return self.exmarks[1][4].sign_hl_group
      end,
    }, {
      provider = '  ',
    },
  },
})

M.diagnostics = utils.insert(signs_from_namespace('diagnostic/signs'), {
  {
    fallthrough = false,
    {
      condition = conditions.has_diagnostics,
      provider = function (self)
        return string.format('%s', self.exmarks[1][4].sign_text:gsub('%s+', ''))
      end,
      hl = function (self)
        return self.exmarks[1][4].sign_hl_group
      end,
    }, {
      provider = ' ',
    }
  }
})

return M
