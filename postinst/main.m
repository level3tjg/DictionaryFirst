#include <stdio.h>
#include "NSTask.h"

int main(int argc, char *argv[], char *envp[]) {
    if(@available(iOS 13, *)){
        NSTask *task = [[NSTask alloc] init];
        [task setLaunchPath:@"/usr/bin/killall"];
        [task setArguments:@[ @"-9", @"Spotlight" ]];
        [task launch];
    }
	return 0;
}
