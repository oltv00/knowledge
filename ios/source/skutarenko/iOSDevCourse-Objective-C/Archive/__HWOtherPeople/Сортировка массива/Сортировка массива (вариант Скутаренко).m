array - массив и животных и людей

array =
[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {

if ([obj1 isKindOfClass:[ASHuman class]] && [obj2 isKindOfClass:[ASHuman class]]) {

return [[(ASHuman*)obj1 name] compare:[(ASHuman*)obj2 name]];

} else if ([obj1 isKindOfClass:[ASAnimal class]] && [obj2 isKindOfClass:[ASAnimal class]]) {

return [[(ASAnimal*)obj1 nickName] compare:[(ASAnimal*)obj2 nickName]];

} else if ([obj1 isKindOfClass:[ASHuman class]]) {

return NSOrderedAscending;

} else {

return NSOrderedDescending;
}
}];

Так же тут нужно использовать список NSComparisonResult. Как вилите, решений это задачи может быть очень много.