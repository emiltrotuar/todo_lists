document.write """
               <div id="ember-testing-container">
                 <div id="ember-testing"></div>
               </div>
               """
document.write """
               <style>
                 #ember-testing-container {
                   position: absolute; 
                   background: white; 
                   bottom: 0; 
                   right: 0; 
                   width: 640px; 
                   height: 384px; 
                   overflow: auto; 
                   z-index: 888; 
                   border: 1px solid #ccc; 
                 } 
                 #ember-testing { 
                   zoom: 50%; 
                   height: 100%
                 }
               </style>
               """

Ember.Test.adapter = Ember.Test.Adapter.create()

TodoLists.rootElement = '#ember-testing'

# TodoLists.setupForTesting();
TodoLists.Router.reopen
  location: 'none'
    
TodoLists.injectTestHelpers()

