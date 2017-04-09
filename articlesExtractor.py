import pickle

def extractFiles(file_name, news_dir, article_type):
	file_object = open(file_name, 'r')
	
	files = pickle.load(file_object)
	
	print 'copying ' + article_type + ' article files...'
	print len(files)
	
	i=0
	for file in files:
		print 
		ff_name = news_dir + article_type + "_" + str(i) + ".txt"
		print ff_name
		news_file = open(ff_name, "w")
		content = (file['content']).encode('utf-8')

		news_file.write(content)  ##save only file's content
		news_file.close()
		i = i + 1
	

def main():
	
	file_name= "./data20170326/fake_news.pickle"
	news_dir = "./data20170326/fake_news/"
	
	extractFiles(file_name, news_dir, "fake")
	
	file_name = "./data20170326/real_news.pickle"
	news_dir = "./data20170326/real_news/"
	
	extractFiles(file_name, news_dir, "real")
		
		
if __name__ == "__main__":
	main()
	