#!/usr/bin/python

import sys
import csv
from string import Template

enumerations = {
    'selected-appearance': [
        'ui:selected-appearance/ordered-list/decimal'
        , 'ui:selected-appearance/ordered-list/alphabetic/upper'
        , 'ui:selected-appearance/ordered-list/alphabetic/lower'
        , 'ui:selected-appearance/ordered-list/roman/upper'
        , 'ui:selected-appearance/ordered-list/roman/lower'
        , 'ui:selected-appearance/bulleted-list'
    ]
}