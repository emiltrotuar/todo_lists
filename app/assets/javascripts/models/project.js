(function () {
	'use strict';

	TodoLists.Project = DS.Model.extend({
		title: DS.attr('string'),
		isCompleted: DS.attr('boolean')
	});
})();