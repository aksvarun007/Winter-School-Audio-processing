from sklearn import datasets
import numpy as np
iris = datasets.load_iris()
from sklearn.naive_bayes import GaussianNB
from sklearn.naive_bayes import MultinomialNB
import scipy.io
epsilon=0.001
data=scipy.io.loadmat('arr.mat')

test=scipy.io.loadmat('test.mat')
labels=scipy.io.loadmat('labels.mat')
gnb = GaussianNB()



dictarray=np.array(data.items()[0][1])
temp=dictarray+0.001*(np.ones(dictarray.shape,dtype=np.float))

test_array=np.array(test.items()[1][1])
label_array=np.array(labels.items()[0][1])
labels_1=[]
for i in range(label_array.shape[0]):

	labels_1.append(label_array[i][0])



temp_fit=gnb.fit(temp,np.array(labels_1))
#print temp.shape,np.array(labels_1).shape
#print temp_fit.score(temp,np.array(labels_1))

#print temp_fit.get_params(deep=True)
y_pred=temp_fit.predict(test_array)

#print("Number of mislabeled points out of a total %d points : %d"  % (dictarray.shape[0],(labels_1!= y_pred).sum()))

print y_pred

