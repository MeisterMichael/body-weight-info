# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

helpers = ActionController::Base.helpers

default_password = ENV['DEFAULT_PASSWORD'] || 'Test123'

User.destroy_all
SwellMedia::Category.destroy_all
SwellMedia::Article.destroy_all
SwellFitness::Exercise.destroy_all
SwellEcom::Sku.destroy_all
SwellEcom::Product.destroy_all

bio = <<STRING
Hi, glad to know you were here. I'm Michael, newbie nutrition blogger. I like to go anywhere to hunting some food and share with other. About taste, benefit, and where you can findout a good place to eat.
STRING
short_bio = bio

admin_user = User.create( name: 'mikeferg', email: 'meister@spacekace.com', first_name: 'Michael', last_name: 'Ferguson', status: 'active', role: 'admin', password: default_password, short_bio: short_bio, bio: bio, properties: {} )


fitness	= SwellMedia::Category.create( status: 'active', availability: 'anyone', name: 'Fitness' )
food		= SwellMedia::Category.create( status: 'active', availability: 'anyone', name: 'Food' )
# favorites	= SwellMedia::Category.create( status: 'active', availability: 'anyone', name: 'Favorite Things' )


article = SwellMedia::Article.create(
  status: 'active',
  user: admin_user,
  publish_at: Time.now,
  title: 'Excercises',
  subtitle: '',
  description: 'Exercises that use your body weight to develop strength and stamina.',
  category: nil,
  template: 'swell_media/articles/category_show',
  properties: {},
  tags: ['Exercise'],
  # avatar: 'http://cdn1.nourishgent.com/blog/matcha_monk_350x350.jpg',
  # cover_path: 'http://cdn1.nourishgent.com/blog/matcha_monk_1200x800.jpg',
  # avatar_urls: { featured: 'http://cdn1.nourishgent.com/blog/matcha_monk_320x450.jpg' },
)
article.update content: <<HTML
<p>Body weight exercises are a great way to get and stay in shape, without needing expensive gym equiptment.  These exercises are no joke, in fact body weight exercises usually make up at least half of high intensity Crossfit workouts, and are great training for everything from running to cycling.</p>
<p>Best of all, you can get started right now.  At home or the office, it doesn't matter just get moving.  You have no excuse, you can workout anytime, anywhere, and dress in anything (though shorts and a shirt you don't mind sweeting in is preferable), because the only thing you have to do to get fit is get moving.</p>
HTML
puts article.url




# seed exercises
exercise = SwellFitness::Exercise.create(
  name: 'Air Squat',
  description: '1 Rep: stand upright, sit in the air, back up to standing.',
  muscles: ['Quadriceps', 'Hamstrings', 'Glutes'],
  equiptment: [],
  tags: ['Crossfit', 'Strength', 'Cardio', 'Quadriceps', 'Hamstrings', 'Glutes', 'Core', 'Legs', 'Beginner Exercise'],
)
exercise.update content: <<HTML
<p>
The air squat is a great combination strength and cardio exercise, that everyone can do.  There are a number of nuances to get the most out of your squat, but the premise is simple... sit and stand up.  The exercise is very similar to climbing stairs, which is great for strengthening your circulatory system.  This variation of the squat is also works on your core.
</p>
HTML
		exercise.update instruction: <<HTML
<h3>Start Position</h3>
<ul>
<li>Stand fully upright</li>
<li>Look straight forward</li>
<li>Place feed a few inches wider than sholder width</li>
<li>Turn feet out about 40 decrees from parallel</li>
<li>Rest arms at your sides</li>
</ul>
<h3>Movement</h3>
<ol>
<li>Intiate by pushing your bottom backwards, so you </li>
<li>Sit down into a squat position:
  <ul>
	  <li>spread your knees until they are pointing the same direction as your feet</li>
	  <li>bend your knees until your thighs are parallel with the floor</li>
	  <li>raise arms to eye level for balance</li>
	  <li>keep weight on your heels</li>
	  <li>Maintain upright chest and level gaze</li>
  </ul>
</li>
<li>Stand up into starting position</li>
</ol>
<h3>Muscles</h3>
<ul>
<li>Quadriceps</li>
<li>Hamstrings</li>
<li>Glutes</li>
</ul>
HTML
puts exercise.name



product = SwellEcom::Product.create title: 'Band'
product.skus.create code: 'band-1', price: 19.99, name: 'Pink Band'
