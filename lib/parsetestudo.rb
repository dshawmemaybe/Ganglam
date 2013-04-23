def arrayfromnoko(array)
  newarray = []
    array.each { |n|
      newarray.push(n.to_s)
    }
    return newarray
end 

def parseAllClasses
	classes = ["AASP","AAST","AGNR","AMSC","AMST","ANSC","ANTH","AOSC","ARAB","ARCH",
		"AREC","ARHU","ARMY","ARSC","ARTH","ARTT","ASTR","CMSC","ECON","ENGL"]

	classes.each { |c|
		parseClass(c)
	}	
end
def parseClass(testudo)
	page = Nokogiri::HTML(open("#{Rails.root}/testudo/" + testudo + ".html","r"))
 
for i in 0..(page.css("div.course").size - 1) do     
  pageclass = page.css("div.course")[i]["id"] 

  pagetitle = page.css("div.course")[i].css("span.course-title").text 

  pagecredits = page.css("div.course")[i].css("span.course-min-credits").text

  pageclassinfo = page.css("div.course")[i].css("div.approved-course-text").text 

  sections = page.css("div.course")[i].css("div.sections-container") 

  for j in 0..(sections.css("div.section").size - 1) do

    section = sections.css("div.section")[j] 

    sectionid = section.css("span.section-id").text 

    sectioninstructor = section.css("span.section-instructor").text 

    sectiondays = section.css("span.section-days").children
    sectiondays = arrayfromnoko(sectiondays)

    sectionstarttime = section.css("span.class-start-time").children
    sectionstarttime = arrayfromnoko(sectionstarttime)

    sectionendtime = section.css("span.class-end-time").children
    sectionendtime = arrayfromnoko(sectionendtime)

    sectionbuilding = section.css("span.building-code").children
    sectionbuilding = arrayfromnoko(sectionbuilding)

    sectionclassroom = section.css("span.class-room").children
    sectionclassroom = arrayfromnoko(sectionclassroom)

      newclass = Testudo.new(:classid => pageclass, :classname => pagetitle,
        :credits => pagecredits, :description => pageclassinfo,
        :section => sectionid, :instructor => sectioninstructor,
        :sectiondays => sectiondays, :starttimes => sectionstarttime,
        :endtimes => sectionendtime, :building => sectionbuilding,
        :classroom => sectionclassroom)
      newclass.save

    end
  end

end