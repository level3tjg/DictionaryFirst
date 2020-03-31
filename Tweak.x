@interface SFMutableResultSection : NSObject
@property (nonatomic, readonly) NSString *bundleIdentifier;
-(NSDictionary *)dictionaryRepresentation;
@end

%hook HookClass
-(void)setResultSections:(NSOrderedSet *)sectionsSet{
	NSMutableArray *sections = [sectionsSet mutableCopy];
	for(int i = 0; i < [sections count]; i++){
		SFMutableResultSection *section = [sections objectAtIndex:i];
		NSString *bundleId = section.bundleIdentifier;
		if([bundleId containsString:@"dictionary"]){
			[sections removeObjectAtIndex:i];
			[sections insertObject:section atIndex:0];
			break;
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