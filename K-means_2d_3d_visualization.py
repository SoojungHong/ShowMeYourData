
# k-means algorithm
#----------------------
# 2-dimensional data
#----------------------
df = pd.DataFrame({
    'x': [12, 20, 28, 18, 29, 33, 24, 45, 45, 52, 51, 52, 55, 53, 55, 61, 64, 69, 72],
    'y': [39, 36, 30, 52, 54, 46, 55, 59, 63, 70, 66, 63, 58, 23, 14, 8, 19, 7, 24]
})

from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters=3)
kmeans.fit(df)

labels = kmeans.predict(df)
centroids = kmeans.cluster_centers_

fig = plt.figure(figsize=(5,5))
colors = map(lambda x: colmap[x+1], labels)

plt.scatter(df['x'], df['y'], cmap=colors, alpha=0.5, edgecolor='k')
for idx, centroid in enumerate(centroids):
    plt.scatter(*centroid, cmap=colmap[idx+1])
plt.xlim(0, 80)
plt.ylim(0, 80)
plt.show()

#----------------------
# 3-dimensional data 
#----------------------
from matplotlib import pyplot
from mpl_toolkits.mplot3d import Axes3D
import random
colmap = {1: 'r', 2: 'g', 3:' b'}


# 3-dimensional data points
df = pd.DataFrame({
    'x': [12, 20, 28, 18, 29, 33, 24, 45, 45, 52, 51, 52, 55, 53, 55, 61, 64, 69, 72],
    'y': [39, 36, 30, 52, 54, 46, 55, 59, 63, 70, 66, 63, 58, 23, 14, 8, 19, 7, 24],
    'z': [29, 16, 30, 52, 14, 76, 95, 19, 33, 20, 46, 83, 18, 53, 74, 28, 69, 27, 20]
})

from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters=3)
kmeans.fit(df)

labels = kmeans.predict(df)
centroids = kmeans.cluster_centers_

fig = pyplot.figure()
ax = Axes3D(fig)
colors = map(lambda x: colmap[x+1], labels)

ax.scatter(df['x'], df['y'], df['z'], cmap=colors, alpha=0.5, edgecolor='k')

#give the labels to each point
for x_label, y_label, z_label, label in zip(df['x'], df['y'], df['z'], labels):
    ax.text(x_label, y_label, z_label, label)

for idx, centroid in enumerate(centroids):
    ax.scatter(*centroid, cmap=colmap[idx+1])
    ax.text(centroid[0], centroid[1], centroid[2], 'aa', None)
pyplot.show()

