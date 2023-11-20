describe("utils/init.lua", function()
  it("Loads package", function()
    local utils_ok, _ = pcall(require, "gitlab.utils")
    assert._is_true(utils_ok)
  end)

  describe("extract", function()
    it("Extracts a single value", function()
      local u = require("gitlab.utils")
      local t = { { one = 1, two = 2 }, { three = 3, four = 4 } }
      local got = u.extract(t, "one")
      local want = { 1 }
      assert.are.same(want, got)
    end)
    it("Returns nothing with empty table", function()
      local u = require("gitlab.utils")
      local t = {}
      local got = u.extract(t, "one")
      local want = {}
      assert.are.same(want, got)
    end)
  end)

  describe("get_last_word", function()
    it("Returns the last word in a sentence", function()
      local u = require("gitlab.utils")
      local sentence = "Hello world!"
      local got = u.get_last_word(sentence)
      local want = "world!"
      assert.are.same(want, got)
    end)
    it("Returns an empty string without text", function()
      local u = require("gitlab.utils")
      local sentence = ""
      local got = u.get_last_word(sentence)
      local want = ""
      assert.are.same(want, got)
    end)
    it("Returns whole string w/out divider", function()
      local u = require("gitlab.utils")
      local sentence = "Thisdoesnothavebreaks"
      local got = u.get_last_word(sentence)
      assert.are.same(sentence, got)
    end)
    it("Returns correct word w/ different divider", function()
      local u = require("gitlab.utils")
      local sentence = "this|uses|a|different|divider"
      local got = u.get_last_word(sentence, "|")
      local want = "divider"
      assert.are.same(want, got)
    end)
  end)

  describe("format_date", function()
    local current_date = {
      day = 19,
      hour = 22,
      isdst = false,
      min = 0,
      month = 11,
      sec = 44,
      wday = 1,
      yday = 323,
      year = 2023,
    }
    it("Returns days since a valid UTC timestamp", function()
      local stamp = "2023-11-16T19:52:36.946Z"
      local u = require("gitlab.utils")
      local got = u.time_since(stamp, current_date)
      local want = "3 days ago"
      assert.are.same(want, got)
    end)

    it("Returns hours since a valid UTC timestamp", function()
      local stamp = "2023-11-19T19:52:36.946Z"
      local u = require("gitlab.utils")
      local got = u.time_since(stamp, current_date)
      local want = "2 hours ago"
      assert.are.same(want, got)
    end)
    it("Returns readable time if > 1 year", function()
      local stamp = "2011-11-19T19:52:36.946Z"
      local u = require("gitlab.utils")
      local got = u.time_since(stamp, current_date)
      local want = "November 19, 2011"
      assert.are.same(want, got)
    end)
  end)

  describe("remove_first_value", function()
    it("Removes the first value correctly", function()
      local u = require("gitlab.utils")
      local got = u.remove_first_value({ 1, 2 })
      local want = { 2 }
      assert.are.same(want, got)
    end)
    it("Handles a one-length list", function()
      local u = require("gitlab.utils")
      local got = u.remove_first_value({ 1 })
      local want = {}
      assert.are.same(want, got)
    end)
    it("Handles a zero-length list", function()
      local u = require("gitlab.utils")
      local got = u.remove_first_value({})
      local want = {}
      assert.are.same(want, got)
    end)
  end)

  describe("table_size", function()
    it("Works for associative tables", function()
      local u = require("gitlab.utils")
      local got = u.remove_first_value({ 1, 2 })
      local want = { 2 }
      assert.are.same(want, got)
    end)
    it("Handles a one-length list", function()
      local u = require("gitlab.utils")
      local got = u.remove_first_value({ 1 })
      local want = {}
      assert.are.same(want, got)
    end)
    it("Handles a zero-length list", function()
      local u = require("gitlab.utils")
      local got = u.remove_first_value({})
      local want = {}
      assert.are.same(want, got)
    end)
  end)

  describe("contains", function()
    it("Finds a value in a list", function()
      local u = require("gitlab.utils")
      local got = u.contains({ 1, 2 }, 1)
      assert._is_true(got)
    end)
    it("Handles missing values", function()
      local u = require("gitlab.utils")
      local got = u.contains({ 1, 3, 4 }, 2)
      assert._is_false(got)
    end)
    it("Handles empty lists", function()
      local u = require("gitlab.utils")
      local got = u.contains({}, 1)
      assert._is_false(got)
    end)
  end)
end)
