import 'package:flutter/material.dart';

class CircleTask {
  int totalSteps, completedSteps;
  IconData icon;
  List<Color> colors;
  bool isForwardable, isComplet, isBackwardable;
  String taskString;
  CircleTask(int totalSteps, int completedSteps, IconData icon, List<Color> colors,String taskString) {
    this.totalSteps = totalSteps;
    this.completedSteps = completedSteps;
    this.colors = colors;
    this.icon = icon;
    this.taskString = taskString;
    this.fillingTheBools();
  }
  int stepForward() {
    if (this.isForwardable) {
      try {
        this.completedSteps++;
        this.fillingTheBools();
        return this.completedSteps;
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else
      return null;
  }

  int stepBackward() {
    if (this.isBackwardable) {
      try {
        this.completedSteps--;
        this.fillingTheBools();
        return this.completedSteps;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
    else return null;
  }

  bool fillingTheBools() {
    try {
      //! checking if the Task is complet
      if (this.completedSteps == this.totalSteps)
        this.isComplet = true;
      else
        this.isComplet = false;
      //! checking if the Task is forwardable
      if (this.completedSteps < this.totalSteps)
        this.isForwardable = true;
      else
        this.isForwardable = false;
      //! checking if the Task if backwardable
      if (this.completedSteps > 0)
        this.isBackwardable = true;
      else
        this.isBackwardable = false;
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
