@interface SFMutableResultSection : NSObject
-(NSDictionary *)dictionaryRepresentation;
@end

%hook HookClass
-(void)setResultSections:(NSOrderedSet *)sectionsSet{
	NSMutableArray *sections = [sectionsSet mutableCopy];
	for (int i = 0; i < [sections count]; i++){
		SFMutableResultSection *section = [sections objectAtIndex:i];
		if([[section dictionaryRepresentation][@"bundleIdentifier"] isEqualToString:@"com.apple.parsec.dictionary"] || [[section dictionaryRepresentation][@"bundleIdentifier"] isEqualToString:@"com.apple.dictionary"]){
			[sections removeObjectAtIndex:i];
			[sections insertObject:section atIndex:0];
		}
	}
	%orig([sections copy]);
}
%end

%ctor{
	Class resultClass;
	if(@available(iOS 13, *))
		resultClass = %c(SPUIResultsViewController);
	else
		resultClass = %c(SPUIResultViewController);
	%init(HookClass = resultClass);
}