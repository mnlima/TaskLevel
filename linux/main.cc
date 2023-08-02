#include "task_levellication.h"

int main(int argc, char** argv) {
  g_autoptr(MyApplication) app = task_levellication_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
