# ALGORITHM
1. Preparation
	1.1 Colored Image -> Grayscale -> Inversion needed(See A1)? -> Binary Matrix
	1.2 Remove all whitespace from the sides
		1.2.1 Scan from top-most row, if all pixels in that row are white, mark as IGNORE. Do until 1st Black pixel. Note the row.
		1.2.2 Scan from bottom-most row, _do same as above_
		1.2.3 Scan from left-most column, if all pixels in that column are white, mark as IGNORE, Do until Black pixel. Note the column.
		1.2.4 Scan from right-most column, _do same as above_
	1.3 Identify individual characters.
		1.3.1 From 1st all white to next all white column = width, mark these columns for each character. Height fixed due to 1.2.1, 1.2.2.

2. Use Decision Tree

# ASSUMPTIONS

| Sr. | Assumption                                         | Reasoning                   | Exceptions              | Fix               |
| --- | -------------------------------------------------- | --------------------------- | ----------------------- | ----------------- |
| A1. | Camera gives similar images - brightness, contrast | "I'm willing to invest"     | Colored background, etc | Light sensor, etc |
| A2. | Fixed font size, style                             | "It is", NECESSARY FOR TREE | Nope. Not allowed       |                   |
| A3. | Images are straight vertically                     | :(                          | Find 'theta'            |                   |
| A4. | No noisy Images                                    | Well...                     | Noisy!!                 | Cluster Technique |

# ISSUES
1. MINOR : How to store grid boundaries. Simple variables should be enough.
2. MAJOR : Extracting info from samples. Creating a static decision tree. (Now imagine if dynamic, using supervised learning for creating decision tree, we can recognize all fonts)
3. Threshold value for step 1.1 based on brightness and contrast of given images.
4. Decision Tree could use some entropy calculations, if you're willing. :P

# CLUSTERING AND PERCENTAGES
1. Clustering
	When I come across a black pixel, I also check the neighborhood to make sure that it's a character pixel rather than noise.
2. Percentages
	I calculate the %pixel for each grid based on sample images. Then the problem is simply about compare percentages in each grid.
	This combined with decision tree may be faster. :)

| Dimensions | Number | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   |
| ---------- | ------ | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 47*70      | 0      | 176 | 135 | 175 | 205 | TH  | 200 | 192 | 127 | 196 |
| 26*69      | 1      | 60  | 86  | 175 | TH  | TH  | 168 | TH  | TH  | 168 |
| 45*69      | 2      | 151 | 132 | 204 | TH  | 107 | 164 | 235 | 218 | 144 |
| 44*70      | 3      | 148 | 123 | 183 | TH  | 95  | 216 | 161 | 114 | 205 |
| 47*68      | 4      | 0   | 140 | 175 | 149 | 95  | 192 | 135 | 158 | 256 |
| 45*69      | 5      | 184 |     |     |     |     |     |     |     |     |
| 45*70      | 6      |     |     |     |     |     |     |     |     |     |
| 45*68      | 7      |     |     |     |     |     |     |     |     |     |
| 45*70      | 8      |     |     |     |     |     |     |     |     |     |
| 44*70      | 9      |     |     |     |     |     |     |     |     |     |
