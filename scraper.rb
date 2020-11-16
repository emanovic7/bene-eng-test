require 'pry'
require 'pry-byebug'
require 'pdf/reader'
require 'spreadsheet'
require 'docsplit'
require 'csv'
require 'combine_pdf'


class Scraper 

  # def parse_pdf_file(pdf_file)
  #   reader = PDF::Reader.new("./files/#{pdf_file}")
  #   binding.pry
  #   #self.populate_excel_template(reader)
    
  # end

  # def populate_excel_template(parsed_file)
  #   excel = Spreadsheet.open "./files/benefix_excel.xls"
  #   sheet1 = excel.worksheet 0
  #   sheet1.each do |row|
  #     #binding.pry
  #   end
  #   parsed_file.pages.each do |page|
  #     #binding.pry
  #     puts page
  #   end
  # end

  # def page_lines(parsed_file)
  #   lines = []

  #   parsed_file.pages
  # end

  def parse_pdf_file(pdf_file, noblank = true)
    file = Dir["files/#{pdf_file}"]
    Docsplit.extract_text(file, :ocr => false, :output => 'storage/text') 
    #resulting_file = Docsplit.extract_text(file)
    #pdf_to_text(resulting_file)
  end

  # def read_text_file
  #   my_array = [];
  #   IO.foreach('storage/text/para05.txt') do |line|
  #     my_array << line
  #   end
  #   binding.pry
  # end

  # def pdf_to_text
  #   new_file = File.new('para06.txt')
  #   new_text = []
  #   binding.pry
  #   new_file.readlines.each do |l|
  #     binding.pry
  #     l.chomp! if noblank
  #   end
  # end

  def pdf_to_text
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
    column_to_add=["new value 1","new value 1"] 

    CSV.open('./files/data.csv', "wb") do |csv|
      csv << ["header 1", "header 2", "header 3", "header 4"]
        CSV.foreach('./files/data.csv', headers: true) do |row,index|
            csv << [row[1], row[2] , row[3] , column_to_add[index]]
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
