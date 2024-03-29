/**
 @preserve
 Copyright (c) 2001-2018 by Wincor Nixdorf International GmbH,
 Heinz-Nixdorf-Ring 1, 33106 Paderborn, Germany

 This software is the confidential and proprietary information
 of Wincor Nixdorf.
 You shall not disclose such Confidential Information and shall
 use it only in accordance with the terms of the license agreement
 you entered into with Wincor Nixdorf.


 */

/**
 * The question code-behind provides the life-cycle for the <i>question</i> view.
 * @module question
 * @since 1.0/00
 */
define(['knockout', 'code-behind/baseaggregate', 'vm-util/UICommanding', 'vm/MessageViewModel'], function(ko, base, commanding) {
    console.log("AMD:question");

    const _logger = Wincor.UI.Service.Provider.LogProvider;
    const _movements = Wincor.UI.Content.ObjectManager;

    const CMD_SCROLL_DOWN = "BTN_SCROLL_DOWN";
    const CMD_SCROLL_UP = "BTN_SCROLL_UP";

    function showScrollButtons() {
        let movElem = _movements.getElementById("MESSAGE");
        if(movElem && base.config.viewType === "softkey" && movElem.canMove() && commanding.hasCommand(CMD_SCROLL_DOWN) && commanding.hasCommand(CMD_SCROLL_UP)) {
            commanding.setVisible(CMD_SCROLL_UP, true);
            commanding.setActive(CMD_SCROLL_DOWN, true);
        }
    }

    return /** @alias module:question */ base.extend({
        name: "question",

        /**
         * Sets again the <i>flexMessageContainerHeader</i> visible, which was set hidden in {@link module:question.activate}.
         * @see {@link module:baseaggregate.canDeactivate}.
         * @lifecycle view
         * @returns {boolean | Promise}
         */
        canDeactivate: function() {
            _logger.log(_logger.LOG_DETAIL, "* | VIEW_AGGREGATE question:canDeactivate");
            base.jQuery("#flexMessageContainerHeader").css("visibility", "visible");  // allow message via header
            return base.canDeactivate();
        },

        /**
         * Instantiates the {@link Wincor.UI.Content.MessageViewModel} viewmodel.
         * @see {@link module:baseaggregate.activate}.
         * @lifecycle view
         * @return {Promise} resolved when activation is ready.
         */
        activate: function() {
            _logger.log(_logger.LOG_DETAIL, "* | VIEW_AGGREGATE question:activate");
            base.jQuery("#flexMessageContainerHeader").css("visibility", "hidden"); // suppress message via header
            let vm = new Wincor.UI.Content.MessageViewModel();
            vm.compositionUpdatedObservable = ko.observable();
            base.container.add(vm, ["flexMain"]);
            return base.activate();
        },

        /**
         * Overridden to show scroll buttons on a softkey based layout when the text is more then fit into the message box.
         * @see {@link module:baseaggregate.compositionComplete}.
         * @lifecycle view
         */
        compositionComplete: function(view, parent) {
            _logger.log(_logger.LOG_DETAIL, "* | VIEW_AGGREGATE question:compositionComplete");

            // Softkey: Control the height of the message area in case the "OTHER" button is available
            if(base.config.viewType === "softkey") {
                commanding.whenAvailable(["OTHER"]).then(() => {
                    if(commanding.get("OTHER").viewState.value() !== 3) {
                        base.jQuery(".messageArea").attr("data-other-available", true);
                    }
                });
            }

            base.compositionComplete(view, parent);
            base.container.whenActivated().then(() => {
                showScrollButtons();
                // code your specific stuff here
            });
        },

        /**
         * Overridden to show scroll buttons on a softkey based layout when the text is more then fit into the message box.
         * @see {@link module:baseaggregate.compositionUpdated}.
         * @lifecycle view
         */
        compositionUpdated: function() {
            _logger.log(_logger.LOG_DETAIL, "* | VIEW_AGGREGATE compositionComplete:compositionUpdated");
            base.compositionUpdated();
            base.container.getById("flexMain").compositionUpdatedObservable(Date.now());
            base.container.whenActivated().then(() => {
                _movements.reCalculateObjects(); // update the grid
                showScrollButtons();
            });
        }
    });
});
