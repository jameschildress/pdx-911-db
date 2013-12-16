require 'uri'
require 'cgi'
require 'net/http'
require 'rexml/document'

require 'rubygems'
require 'bundler/setup'
require 'pg'

require_relative 'record'
require_relative 'agency'
require_relative 'category'
require_relative 'dispatch'

require_relative 'database'
require_relative 'api'
require_relative 'scraper'
