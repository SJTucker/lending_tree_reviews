from urllib.request import Request, urlopen
from bs4 import BeautifulSoup
import time
import json

from review import Review

url = 'https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183?pid='
hdr = {'User-Agent': 'Mozilla/5.0'}

def request_page(page_number,url,hdr):
	url = f'{url}{page_number}'
	req = Request(url, headers=hdr)
	page = urlopen(req)
	html = BeautifulSoup(page, 'html.parser')
	#import pdb; pdb.set_trace()
	more_reviews = True if html.find('ul', class_='lenderNav').find(text='Next') else False
	#more_reviews = False
	print(url)
	review_panels = html.find_all('div', class_='mainReviews')
	return more_reviews, review_panels

reviews = []
more_reviews = True
page_number = 1

while more_reviews:
	more_reviews, review_panels = request_page(page_number,url,hdr)
	# if page_number == 3:
	# 	import pdb; pdb.set_trace() 

	for review in review_panels:
		consumer = review.find('p',class_='consumerName').text.split('from')
		review_points = review.find('div',class_='reviewPoints')
		#print(review)
		rev = {
			'title': review.find('p',class_='reviewTitle').string,
			'body': review.find('p',class_='reviewText').string,
			'rating': review.find('div',class_='numRec').string,
			'author': consumer[0].strip(),
			'location': consumer[1].strip(),
			'date': review.find('p',class_='consumerReviewDate').string.split('in')[1].strip(),
			'closedWithLender': 'Yes' if review_points.find('div',class_='yes') else 'No',
			'loanType': review_points.find('div',class_='loanType').string,
			'reviewType': review_points.find('div',class_='loanType').string
		}
		reviews.append(rev)
		#time.sleep(1)

	print('******')
	print(page_number)
	page_number += 1
	#moreReviews = False

print(len(reviews))