# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {
    first_name:  "Administrator",
    last_name: "Example",
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password",
    role: "admin"
  },
  {
    first_name:  "User",
    last_name: "Example",
    email: "user@example.com",
    password: "password",
    password_confirmation: "password",
    role: "guest"
  }
]

users.each { |user| User.create!(user) }

organizations = [
  {
    name: "Academy at Sisters",
    location: "Bend",
    ages_served: "13 - 18",
    programs: "In-school",
    contact_number: "541-389-2748",
    contact_email: "",
    website: "http://www.academyatsisters.org"
  },
  {
    name: "Assistance League of Bend",
    location: "Bend",
    ages_served: "4th - 5th grade",
    programs: "Afterschool or non-school days",
    contact_number: "541-389-2075",
    contact_email: "info@assistanceleaguebend.com",
    website: "https://www.assistanceleague.org"
  },
  {
    name: "Base Camp Studio",
    location: "Bend",
    ages_served: "Pre-K - Teenagers",
    programs: "Afterschool or non-school days",
    contact_number: "503-953-2175",
    contact_email: "hello@basecampstudio.org",
    website: "https://basecampstudio.org"
  },
  {
    name: "Bend Parks and Rec",
    location: "Bend",
    ages_served: "K - 17",
    programs: "Afterschool or non-school days",
    contact_number: "541-389-7275",
    contact_email: "kim@bendparksandrec.org",
    website: "https://bendparksandrec.org"
  },
  {
    name: "Bend Science Station",
    location: "Bend",
    ages_served: "3rd - 12th grade",
    programs: "Afterschool or during the summer",
    contact_number: "541-330-0433",
    contact_email: "",
    website: "https://www.bendsciencestation.com"
  },
  {
    name: "Big Brothers Big Sisters of Central Oregon",
    location: "",
    ages_served: "6 - 18",
    programs: "Afterschool or non-school days",
    contact_number: "541-312-6047",
    contact_email: "info@bbbsco.org",
    website: "http://www.bbbsco.org"
  },
  {
    name: "Boy Scouts",
    location: "",
    ages_served: "11 - 17",
    programs: "Afterschool or non-school days",
    contact_number: "",
    contact_email: "",
    website: "https://www.craterlakecouncil.org"
  },
  {
    name: "Caldera Arts",
    location: "",
    ages_served: "6th - 12th grade",
    programs: "Weekends/Summer",
    contact_number: "541-595-0956",
    contact_email: "Caldera@CalderaArts.org",
    website: "http://calderaarts.org"
  },
  {
    name: "Cascade Youth and Family Center",
    location: "Bend and Redmond",
    ages_served: "12 - 21",
    programs: "",
    contact_number: "541-382-0934",
    contact_email: "cyfc@jbarj.org",
    website: "http://cascadeyouthandfamilycenter.org"
  },
  {
    name: "Central Oregon Disability Support Network",
    location: "Bend and Redmond",
    ages_served: "",
    programs: "Afterschool or non-school days",
    contact_number: "541-548-8559",
    contact_email: "",
    website: "https://ocdd.org"
  },
  {
    name: "Children's Forest",
    location: "Bend",
    ages_served: "K - 12",
    programs: "Weekends or non-school days",
    contact_number: "541-383-5592",
    contact_email: "katie@childrensforestco.org",
    website: "http://www.childrensforestco.org"
  },
  {
    name: "Childrens Museum of Central Oregon",
    location: "Bend",
    ages_served: "K - 12",
    programs: "In-school programs or summer camps",
    contact_number: "",
    contact_email: "info@childrensmuseumco.org",
    website: "http://www.childrensmuseumcentraloregon.org"
  },
  {
    name: "Circle of Friends",
    location: "Sisters",
    ages_served: "K - 12",
    programs: "Afterschool or non-school days",
    contact_number: "541-588-6445",
    contact_email: "info@circleorfriendsoregon.org",
    website: "http://circleoffriendsoregon.org"
  },
  {
    name: "Crook County 4H",
    location: "",
    ages_served: "",
    programs: "In-school programs or afterschool",
    contact_number: "",
    contact_email: "",
    website: "https://extension.oregonstate.edu/4h/crook"
  },
  {
    name: "Crook County After the Bell",
    location: "Prineville",
    ages_served: "5 - 10",
    programs: "Afterschool or non-school days",
    contact_number: "541-233-4501",
    contact_email: "",
    website: "https://childcarecenter.us/provider_detail/crook_county_after_the_bell_prineville_or"
  },
  {
    name: "Crook County for the Children",
    location: "Prineville",
    ages_served: "",
    programs: "",
    contact_number: "541-416-1827",
    contact_email: "",
    website: ""
  },
  {
    name: "Deschutes Children's Foundation",
    location: "Bend, Redmond, and La Pine",
    ages_served: "",
    programs: "",
    contact_number: "541-388-3101",
    contact_email: "",
    website: "https://www.deschuteschildrensfoundation.org"
  },
  {
    name: "Deschutes County 4H",
    location: "",
    ages_served: "4 - 8",
    programs: "In-school programs or afterschool",
    contact_number: "541-548-6088",
    contact_email: "",
    website: "http://deschutes4h.com"
  },
  {
    name: "Discover Your Forest",
    location: "Bend",
    ages_served: "K - 12",
    programs: "In-school programs or afterschool",
    contact_number: "541-383-4771",
    contact_email: "info@discoveryourforest.org",
    website: "http://discoveryourforest.org"
  },
  {
    name: "Friends of the Children",
    location: "Bend",
    ages_served: "K - 12",
    programs: "Afterschool or non-school days",
    contact_number: "541-668-6836",
    contact_email: "info@friendscentraloregon.org",
    website: "https://friendscentraloregon.org"
  },
  {
    name: "Girl Scouts",
    location: "",
    ages_served: "11 - 17",
    programs: "Afterschool or non-school days",
    contact_number: "800-338-5248",
    contact_email: "",
    website: "http://www.girlscoutsosw.org"
  },
  {
    name: "Healing Reins",
    location: "Bend",
    ages_served: "",
    programs: "Non-school days",
    contact_number: "541-382-9410",
    contact_email: "",
    website: "https://healingreins.org"
  },
  {
    name: "J Bar J Learning Center",
    location: "",
    ages_served: "",
    programs: "",
    contact_number: "541-389-1409",
    contact_email: "pprice@jbarj.org",
    website: "http://www.jbarj.org/j-bar-j-boys-ranch/j-bar-j-learning-center"
  },
  {
    name: "Kids Club of Jefferson County",
    location: "Madras and Warmsprings",
    ages_served: "",
    programs: "Afterschool or non-school days",
    contact_number: "541-475-7028",
    contact_email: "kidsclub@509j.net",
    website: "https://jckidsclub.com"
  },
  {
    name: "Kids in the Game",
    location: "Bend",
    ages_served: "K - 5th",
    programs: "In-school programs or afterschool",
    contact_number: "541-508-3966",
    contact_email: "",
    website: "https://kidsinthegame.org"
  },
  {
    name: "Oregon Adaptive Sports",
    location: "Bend",
    ages_served: "",
    programs: "Non-school days",
    contact_number: "541-306-4774",
    contact_email: "info@oregonadaptivesports.org",
    website: "http://oregonadaptivesports.org"
  },
  {
    name: "Crook County Parks and Rec",
    location: "Powell Butte and Prineville",
    ages_served: "Pre-K - 12",
    programs: "Afterschool or non-school days",
    contact_number: "541-447-1209",
    contact_email: "Info@CCPRD.org",
    website: "http://ccprd.org"
  },
  {
    name: "Redmond Parks and Rec",
    location: "Redmond",
    ages_served: "",
    programs: "Afterschool or non-school days",
    contact_number: "541-548-7275",
    contact_email: "raprd@raprd.org",
    website: "https://www.raprd.org"
  },
  {
    name: "Samara Learning Center",
    location: "Bend",
    ages_served: "1st - 8th",
    programs: "In-school programs or non-school days",
    contact_number: "541-419-3324",
    contact_email: "",
    website: ""
  },
  {
    name: "The Landing",
    location: "",
    ages_served: "",
    programs: "Afterschool or non-school days",
    contact_number: "458-231-1843",
    contact_email: "",
    website: "http://centraloregonyouth.org"
  },
  {
    name: "Together for Children",
    location: "Bend",
    ages_served: "Pre-K - K",
    programs: "",
    contact_number: "541-420-2611",
    contact_email: "",
    website: "http://www.together-for-children.org"
  },
  {
    name: "Warm Springs Boys and Girls Club",
    location: "Warm Springs",
    ages_served: "K - 12",
    programs: "Afterschool or non-school days",
    contact_number: "541-553-1161",
    contact_email: "",
    website: "warmsprings-nsn.gov"
  },
  {
    name: "Heart of Oregon Corps",
    location: "Redmond, Bend, La Pine, Prineville, Madras, Warm Springs, Culver, Sisters, and Crescent",
    ages_served: "16 - 24",
    programs: "",
    contact_number: "541-633-7834",
    contact_email: "",
    website: "http://heartoforegon.org"
  },
  {
    name: "SMART",
    location: "Crook, Deschutes, and Jefferson Counties",
    ages_served: "Pre-K - 3rd",
    programs: "",
    contact_number: "541-797-7726",
    contact_email: "",
    website: "https://www.getsmartoregon.org/about-smart/local-offices/central-area"
  },
  {
    name: "REACH Redmond",
    location: "Redmond",
    ages_served: "5 - 17",
    programs: "Afterschool, school breaks, and summer",
    contact_number: "541-504-9060",
    contact_email: "info@reachredmond.org",
    website: "http://reachredmond.org/"
  },
  {
    name: "Boys and Girls Club of Bend",
    location: "Bend",
    ages_served: "5 - 18",
    programs: "Afterschool, school breaks, and summer",
    contact_number: "541-617-2877",
    contact_email: "info@bgcbend.org",
    website: "https://www.bgcbend.org/"
  },
  {
    name: "After School Buddies",
    location: "Bend",
    ages_served: "Elementary/Middle",
    programs: "Afterschool, school breaks, and summer",
    contact_number: "541-390-3046",
    contact_email: "afterschoolbuddies@gmail.com",
    website: "http://www.afterschoolbuddies.org/"
  },
  {
    name: "Crook County Kids Club",
    location: "Prineville",
    ages_served: "Elementary",
    programs: "Afterschool, school breaks, and summer",
    contact_number: "541-447-7661",
    contact_email: "director@crookcountykids.org",
    website: "http://cckids.snappages.com/"
  },
  {
    name: "Camp Fire Central Oregon",
    location: "Central Oregon",
    ages_served: "5 - 18",
    programs: "Camps, afterschool, school breaks, and summer",
    contact_number: "541-382-4682",
    contact_email: "info@campfireco.org",
    website: "https://campfireco.org/"
  },
  {
    name: "OSU Open Campus: Juntos",
    location: "Central Oregon",
    ages_served: "Grades 8 - 12",
    programs: "Family engagement, camps, and college visits",
    contact_number: "Deschutes: 541-212-4884, Crook/Jefferson: 541-550-6966",
    contact_email: "Ruth.Jones@oregonstate.edu",
    website: "http://opencampus.oregonstate.edu/programs/juntos/"
  },
  {
    name: "ASPIRE",
    location: "Central Oregon",
    ages_served: "Grades 8 - 12",
    programs: "Mentoring",
    contact_number: "541-515-4513",
    contact_email: "Stacey.Stonesifer@hecc.oregon.gov",
    website: "https://www.aspireoregon.org/"
  },
  {
    name: "Deschutes Public Library",
    location: "Deschutes",
    ages_served: "All ages",
    programs: "Library, story time, and classes",
    contact_number: "",
    contact_email: "",
    website: "https://www.deschuteslibrary.org/"
  }
]

organizations.each { |organization| Organization.create!(organization) }
