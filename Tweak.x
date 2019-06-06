@interface SFMutableResultSection : NSObject
-(NSDictionary *)dictionaryRepresentation;
@end

@interface SPUIResultViewController : NSObject
-(NSArray *)resultSections;
-(void)setResultSections:(NSArray *)sections;
@end

%hook SPUIResultViewController
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