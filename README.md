# SRIMRangeDist
A MATLAB-based GUI for plotting multiple profiles of SRIM Range Distribution of Ions.

[SRIM](http://www.srim.org/) is a software that does Monte Carlo simulation of ion implantations. It can estimate the distribution of ions and target damages after an implantation. **SRIMRangeDist** helps SRIM users to plot the ion distribution data from a SRIM output with relative ease. In some occassions, SRIM users need to calculate the distribution statistics of a series of several ion implantations and do a trial-and-error work to get the optimal implantation parameters. Performing this kind of task manually in a data processing software can be a bit mundane. **SRIMRangeDist** allows users to plot multiple implantation profiles on the same graph, and it computes the total distribution and the 95% confidence interval of the distribution for a quick reviewing of many implantation scenarios.

## Main Features
- Plot up to seven SRIM data from multiple implantation profiles.
- Compute the mean and range of the 95% confidence interval of the total ion distribution.

## How to Use
1. Put the RANGE.txt file from a SRIM output into a folder with an integer name, and then put this folder into another folder so that the directory looks like, for example: `data/123/RANGE.txt`. Tips: choose the integer to be the implantation energy.
2. Specify the `data` folder, target's mass density, and target's molar mass in the user interface.
3. Also specify a few pairs of subfolder number and the corresponding implantation fluence in the input table.
4. The x-axis limit can be optionally set.
5. Push the PLOT button.

## Tested On
- MATLAB R2015b

## Screenshots
![SRIMRangeDist User Interface](/screenshot1.png) 
