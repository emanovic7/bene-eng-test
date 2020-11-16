require 'combine_pdf'
require 'pdf/reader'
require 'docsplit'
require 'csv'
require 'combine_pdf'

require 'pry'
require 'pry-byebug'


class PDFScraper 

  #get pdf
  #split pdf
  #parse pdf
  #write pdf content to csv
  #turn csv into excel

  #CSV
  #columns/ headers by data give

  def create_csv_file
    headers = ["start_date", 
                "end_date", 
                "product_name", 
                "states", 
                "group_rating_areas", 
                "zero_eighteen", 
                "nineteen_twenty",
                "twenty_one",
                "twenty_two",
                "twenty_three",
                "twenty_four",
                "twenty_five",
                "twenty_six",
                "twenty_seven",
                "twenty_eight",
                "twenty_nine",
                "thirty",
                "thirty_one",
                "thirty_two",
                "thirty_three",
                "thirty_four",
                "thirty_five",
                "thirty_six",
                "thirty_seven",
                "thirty_eight",
                "thirty_nine",
                "forty"]
    CSV.open('benefix_small_group_plans_template.csv', 'a+') do |row|
      row << headers
    end
  end

  def write_to_csv
    File.open('./storage/text/1.txt') do |text_file|
      File.open('benefix_small_group_plans_template.csv', 'a+') do |csv_file|
        text_file.each do |line|
          start_date =  
          binding.pry
          csv_file << line.squeeze(' ').gsub(' ', ',')
        end
      end
    end 
  end

  def scrape_pdf(file)
    split_pdf(file)
    parse_pdf_file('1.pdf')
    #write pdf content to existing csv
    #turn csv into excel
  end

  def parse_pdf_file(file)
    file = Dir["files/#{file}"]
    Docsplit.extract_text(file, :ocr => false, :output => 'storage/text').split(/\t/)
  end

  def split_pdf(file)
    pages = CombinePDF.load("./files/#{file}").pages
    i = 1
    pages.each do |page|
      pdf = CombinePDF.new
      pdf << page 
      pdf.save("#{i}.pdf")
      i+=1
    end
  end 

end

test = PDFScraper.new
#test.create_csv_file
#test.scrape_pdf('para01.pdf')
test.write_to_csv
