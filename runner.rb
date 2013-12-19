#!/usr/bin/env ruby

require_relative 'lib/scraper'

logger = Logger.new('pdx911.log', 10, 1024000)
logger.level = Logger::INFO

PDX911::Scraper.run logger

logger.close