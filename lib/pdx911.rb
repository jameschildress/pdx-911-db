require 'rubygems'
require 'bundler/setup'
require 'pg'

require 'uri'
require 'cgi'
require 'net/http'
require 'rexml/document'

require_relative 'record'
require_relative 'agency'
require_relative 'category'
require_relative 'dispatch'

require_relative 'api'
require_relative 'database'
require_relative 'scraper'
