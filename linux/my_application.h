#ifndef FLUTTER_task_levelLICATION_H_
#define FLUTTER_task_levelLICATION_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(MyApplication, task_levellication, MY, APPLICATION,
                     GtkApplication)

/**
 * task_levellication_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #MyApplication.
 */
MyApplication* task_levellication_new();

#endif  // FLUTTER_task_levelLICATION_H_
