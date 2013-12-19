#!/usr/bin/env ruby

require_relative 'pdx911/pdx911'

logger = Logger.new('pdx911.log', 10, 1024000)
logger.level = Logger::INFO

PDX911::Scraper.run logger

logger.close