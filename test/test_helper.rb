# coding: utf-8

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))
$LOAD_PATH.unshift APP_ROOT
$LOAD_PATH.unshift File.join(APP_ROOT)
$LOAD_PATH.unshift File.join(APP_ROOT, 'lib')

require "logger"
require "fragile"
Fragile.logger.level = Logger::DEBUG

require "minitest/spec"
require "minitest/autorun"

