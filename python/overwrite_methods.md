


How to overwrite even __ methods (even if this shouldn't be something to be done)
https://stackoverflow.com/questions/1301346/what-is-the-meaning-of-single-and-double-underscore-before-an-object-name


````python
class Anonymize:
    def __init__(self, p_params_initialization):
        self.params_initialization = p_params_initialization

    def __do_anonymous(self):
        print ("Do __Anonymous")

    def blabla(self):
        print("blabla")

    def get_dataframe(self):

        self.__do_anonymous()

class bn_anonymize (Anonymize):

    def _Anonymize__do_anonymous(self):
        print("antes")
        super()._Anonymize__do_anonymous()
        print("depois")

    def blabla(self):
        print("antes")
        super().blabla()
        print ("depois")



bn = bn_anonymize(p_params_initialization="BLA");

bn.get_dataframe()

````
