require 'pry'
require 'pry-byebug'
require 'pdf/reader'
require 'spreadsheet'
require 'docsplit'
require 'csv'
require 'combine_pdf'


class Scraper 

  def scrape_pdf_data(pdf_file)
    #1. Split pdf into individual files
    split_files = split_pdfs(pdf_file)

    #2. Convert to .txt
    split_files.each do |split_file|
      parse_pdf_file(pdf_file)
    end

    #3. Parse data from txt file for data
    parse_txt

    #4. Write data to csv
    write_to_csv

    #5. Convert back to .xlsx

  end

  def parse_pdf_file(pdf_file, noblank = true)
    file = Dir["files/#{pdf_file}"]
    Docsplit.extract_text(file, :ocr => false, :output => 'storage/text') 
  end

  def parse_txt
    finalArr = []
    File.open('./storage/text/0.txt') do |f|
      f.each_line do |line|
        #binding.pry
        # line.gsub /^$\n/, ''
        finalArr << line.split("\n")
      end
      binding.pry
    end
    #binding.pry
    CSV.open('./files/data.csv', 'w') do |csv|
      csv << finalArr
    end
  end

  def split_pdfs
    pages = CombinePDF.load('./files/para05.pdf').pages
    i = 0
    pages.each do |page|
      pdf = CombinePDF.new
      pdf << page 
      pdf.save("#{i}.pdf")
      i+=1
    end
  end

  def write_to_csv
    CSV.open('./files/data.csv', "wb") do |csv|
      csv << ["header 1", "header 2", "header 3", "header 4"]
        CSV.foreach('./files/data.csv', headers: true) do |row,index|
            csv << []
        end
    end
  end

end

test = Scraper.new
#test.parse_pdf_file("para03.pdf")
#test.parse_pdf_file("0.pdf")
# test.parse_pdf_file("para07.pdf")
#test.parse_pdf_file
#test.read_text_file
test.write_to_csv
#test.split_pdfs
