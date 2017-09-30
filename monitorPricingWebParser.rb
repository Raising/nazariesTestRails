require 'json'
class MonitorPricingWebParser 

  attr_reader :source
  attr_reader :monitor
  attr_reader :check_rate
  attr_reader :history
  attr_reader :multiple_notifications
  attr_reader :push_notifications
  attr_reader :price_yearly
  attr_reader :price_monthly


  def retrieveMonitorPricing (page)
  	@source = page
  	productsList = Array.new

  	productsDom = @source.css('div.product')
  	productsDom.each do |product|
  		productsList.push(domToObject(product))
  	end
  	return productsList
  end

  def domToObject (productHtml)
  	product = {}

  	product["monitors"] = 					productHtml.css("h2").text
	product["chek_rate"] = 				productHtml.css('dd:nth-child(2)').text().split(' ')[1]
	product["history"] = 					productHtml.css('dd:nth-child(4)').text().split(' ')[0]
	product["multiple_notifications"] = 	productHtml.css('dd:nth-child(6) span').text() == "Yes"
	product["push_notification"] = 		productHtml.css('dd:nth-child(8) span').text() == "Yes"
	product["price"] = 					productHtml.css('p:not(.billing_options) a').text().split(' ')[0][1..-1]
	return product
  end
end