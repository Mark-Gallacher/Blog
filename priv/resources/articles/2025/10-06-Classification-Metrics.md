%{
  title: "Evaluating Classification Metrics for Imbalanced Data",
  tags: ~w(Statistics Python Machine-Learning Dissertation Classification Metrics Data-Visualisation),
  description: "Knowing what model is use, how to configure the model and
evaluating the model are all dependant on the choice of metric. If our data is
not equally balanced across all of our groups, models will tend to perform
better with the larger classes. The weaker performance with the smaller classes
can go unnoticed, if an improper metric is used to evaluate the model. This
issue is particularly problematic when we are training on medical data.", show:
true,
  image: "Prec_Recall_Classes.png"
}
---

## Quick Summary

Machine learning has been around for quite a while and covers simple regression
models to sophisticated deep neural networks. Typically, a model has tunable
features to ensure the best performance in various settings and different
datasets. Tuning theses features, called *Hyperparameters*, and choosing the
best type of model depend on some evaluation of performance. This could be as
simple as counting the number of correct predictions, finding the total difference
between all predicted value and the actual values, or more complicated metrics.
Given we are spoilt for choice with the number of models we could use, and the
metrics that are available to evaluate them, it's worth highlighting some
potential issues that may pop up.

This dissertation focuses on one type of problem, that is the issue of
imbalanced datasets. This is when we don't have an even split of samples across
the groups we hope to predict. If our training data was made up of images of
cats and dogs, and 90% of our images happened to be cats. Our model achieves an
accuracy of 90% by *always* guessing cats. Looking at the metric alone, we might
think our model is going some complex maths involving convolutions to generate
a pretty good performance. This is a silly example to show the weakness of some
metrics, especially with imbalanced data. Imagine a more serious example, where
we are training on medical data. It would be incredibly weird if diseases or
conditions were perfectly balanced. If we trained a model and it *never*
predicted one of the rarer diseases, the consequences aren't as trivial of
labelling a dog as a cat. More generally, the smaller groups will have much
poorer accuracy compared to larger groups.

## A Little Background

The data we are going to use is about different types of high blood pressure,
notably the rare versions that are defined by some hormonal complication. These
are pretty difficult to diagnosis as they require some specialised or expensive
tests, whilst presenting also identically as "normal" high blood pressure. The
hope is we can simply do a little blood test instead, by measuring the levels
of certain molecules, to make a reliable diagnosis. These molecules are tiny
fragments of RNA, the oxygenated brother of DNA, called microRNA. I will spare
you the biology lesson on why they are cool. Our data is made up of the levels
of 173 different microRNA fragments, for 465 patients. So not a massive
dataset, especially for the number of variables (one microRNA = one variable).

## Overview of the Approach

Given the size of our data, we can rule out deep neural networks (aka AI) or we
would need to trouble ourselves with generating data. Because this is a
classification problem (we want to predict a category instead of a number), we
need to use a *classifier*. With the end goal of making recommendations of what
metrics should be avoided/used, training our data on one type of classifier
isn't very convincing. We would walk into issues like, how do we know this
problematic metric is problematic for *all* models, and not just the one we
used. To avoid this headache, we are going to use different types of models -
Linear, Ensemble, Proximity-Based and Probabilistic. I am going to spare you
the details, but it is useful to know that Ensemble methods train a group of
smaller models, then average across their predictions to make a prediction
better than any one of their individual parts. These are expected to be the
best type of model but are likely more computationally complex. For the
mathematically curious, Linear models are not necessarily trying to fit a
straight line. They are trying to use a linear function instead, meaning they
can generate complex non-linear boundaries (squiggly lines) between classes.
So much for sparing you the details.

I also used a dummy classifier model, or a naive classifier, that doesn't use
any of the information in our data but instead simply guesses the majority
class, for every single sample. You can imagine how useless this would be in
practice but for us, we want to see if our metrics uncover the uselessness of
this model. Ideally, we want a metric that has a high score for a great model
and a low score for a poor model. If our metric is high in this poor model,
would that not mean the metric over-simplifying or over-estimating the
performance or usefulness of our model. We are also going to use a variety of
metrics, without listing all of them, there are three main groups of metrics we
are interested in: 

- **Class-Agnostic Metrics** - Ignore class performances and focus on overall model
performance (think like accuracy - the number of correct divided by number of
guesses)

- **Micro-averaged** - Class-sensitive, they add up the number of correct and
incorrect predictions for each class, then pool them together to calculate the
overall metric. (Let's see we have class A had 8 and 2, class B 9 and 1, and
class C has 1 and 4 correct/incorrect predictions, respectively. We would add
up the correct (8 + 9 + 1) and the total (10 + 10 + 5) guesses before we pass
them to the formula for the metric - so "micro" accuracy would be 72%*).

- **Macro-averaged** - Class-sensitive, they calculate the metric for each
class first, then take the average. (In our example, "macro" accuracy would be
the mean of 8 / 10, 9 / 10 and 1 / 5, so ~63%).

*It is worth pointing our the normal accuracy is the same as the "micro"
accuracy. Although micro metrics use class-specific information, when they
total the values before passing them to the formula - it renders the metric
*class-agnostic*. Also "macro" accuracy is more commonly called *Balanced
accuracy*. Notice how in our simple example, micro averaging increased the
score more than 10% compared to macro averaging. The key difference is how the
smaller (and usually less performant) class is being handled. In our example,
the minority has equally influential on the final metric to the majority class
in the macro averaged metric, instead of being weighted by the size of the
class.

!["Image comparing Micro and Macro averaging methods and the class-specific
metrics"](/images/2025/Classification-Metrics/Prec_Recall_Classes.png "On the
X-axis we have a our type of model, and on the Y-axis we have the median score.
The three plots show the three metrics of interest - Precision, Recall and
F1-Score. With the solid lines displaying the median score for the Micro- or
Macro-averaged metric, we are comparing them with the class-specific
(dashed-lines) to see what information the averaged scored might be hiding.
What is important to note is that Micro-averaged metrics have slightly scores
compared to Macro, the reason for this is how they handle the smaller classes.
The Micro-averaged metric is overlooking the week performance of the minority
in favour of a better performance overall - while the Macro is penalised by the
weak performance in the minority classes. The difference in Recall between RF
and GB shows GB struggling with the CS class (the minority class).
Micro-averaged recall has a minimal decrease whereas Macro has a more sizeable
decrease for the same performance.")

## Glance at the Results

To replicate the nature way a researcher would fit their chosen model to their
data, we aim to explore different sets of hyperparameters for each of our
models. However, different models have various number of hyperparameters, so it
isn't fair to simply average their performance. We first take the top 10
models, for each type of model, for each metric. We get the top 10 models in
accuracy, for one of our linear models, and repeat this across all metrics and
all models. This means we are comparing the best set of hyperparameters for a
given model, with the best set of hyperparameters of another model. I imagine
this isn't very clear, but what we are interested in is if there are any
patterns in our metrics that is present in all of our models. Like do the
metrics agree what is the "best" model? Are the metrics similar to each other
or are they completely different? Hopefully there is some disagreement on what
the "best" model is, or this whole project is not very useful.

!["Image showing the performance of the individual classes across our
models"](/images/2025/Classification-Metrics/Confusion_Matrix.png "The four
panes show the False Negative, False Positive, True Negative and True Positive
Rates across the different models. This is more interesting to look at than it
is informative. Essentially, it aims to show how the smaller classes generally
have poorer performance regardless of the type of model used and their
performance varies considerably more than the larger groups (the length of the
bars). If we look at the FNR panel, it appears models are failing to predict
our label CS (the smallest group) indicating the general bias towards the
majority and the key issue with imbalanced datasets. Also, the really low FPR
for the smallest group is likely due to the model rarely predicting this
label. This is echoed by the higher scores for PHT (our largest group) in the
TPR, albeit 75% isn't very impressive.")

Next, I wanted to explore if we could visualise the consequences of using a
single metric to determine the "best" model. For this, I selected the best set
of hyperparameters for a given model, and repeated this process for every
metric. Concretely, if we used Model A as our algorithm, we now have the best
Model A for accuracy, and a Model A for each of the metrics we used. So
we can compare the models that were "selected" by the different metric with
each other. Then, we want to see how do they handle the individual categories
in our data. In other words, do they all perform the same across the
categories? Do some metrics clearly show bias to the larger groups whilst other
metrics prevent the smaller groups from being left behind? Do the metrics have
a strong value despite a noticeably weak performance in the smaller classes? 

!["Image of True Positive Rates for our Four Categories - for Four
Models"](/images/2025/Classification-Metrics/Best_Conf_Differences_Models.png
"The True Positive Rate (TPR) of our four classes across four different models
(GB, LG, RF, and SVM) when we have defined the best model with a given metric.
The important feature is the movement of the red line - the smallest group in
our data. It seems the choice of metric is much more influential on the
performance of the smaller groups than the larger groups (PHT and PA). In
general, Accuracy doesn't prevent the 'best' model from having a poor
performance in our smallest group, while the Balanced variety of Accuracy
appears to prefer a more even TPR across the different groups.")

## Conclusion

Overall, we showed how class-agnostic metrics tend to overlook the weaker
performance of minority classes and how micro-average metrics behave like these
class-agnostic metrics. Also, we pointed out that the majority of our models
where given a higher score for these class-agnostic metrics compared to
class-specific ones, likely over-estimating the models performance. In
contrast, the macro-averaged metrics tend to highlight this low performance at
the cost of the values for the larger classes. Interestingly, we displayed how
the variance in performance is inversely proportional to the size of the class,
where small classes typically have a wider range of values. This would indicate
the choice of metric should be influenced by how we wish to handle these
minority classes. In a medical setting we wouldn't want to ignore these rare
diseases for simply being more rare whereas for image or text classification
that could have hundreds or thousands of labels, we might prefer to overlook
them.
