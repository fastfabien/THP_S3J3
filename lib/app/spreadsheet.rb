require 'google_drive'

class Spreadsheets

	def save_sa_spreadsheet
		session = GoogleDrive::Session.from_config("config.json")
		spreadsheets = session.spreadsheet_by_title("sama")
		worksheet = spreadsheets.worksheets.first
		ligne = 1
		all_townhall_mail.length.times do |i|
			all_townhall_mail[i].each do |key,value|
				worksheet[ligne,1] = key
				worksheet[ligne,2] = value
			end
			ligne +=1
		end
		worksheet.save
		
	end

	private

	def get_townhall_email(townhall_url)
		townhall_email = 0
		doc = Nokogiri::HTML(open(townhall_url))
			doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |i|
				townhall_email = i.text
			end
		return townhall_email
	end

	def get_townhall_urls
		link = []
		link_with_name = []
		mes = []
		b = []
		doc = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
		doc.xpath('//a[@class = "lientxt"]').each do |i|
			a = i['href']
			t = a.length
			mes << "https://www.annuaire-des-mairies.com#{a[1...t]}"
			b << i.text
		end
		return mes, b
	end


	def all_townhall_mail
		urls_townhall , name_townhall = get_townhall_urls
		all_townhall_name = []
		all_urls = []
		all_name = []
		urls_townhall.length.times do |j|
			all_urls << get_townhall_email(urls_townhall[j])
		end
		name_townhall.length.times do |i|
			all_name << name_townhall[i]
		end
		all_urls.length.times do |k|
			all_townhall_name << {all_name[k] => all_urls[k]}
		end
		return all_townhall_name
	end
end