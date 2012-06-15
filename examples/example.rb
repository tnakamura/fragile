pipeline :foobar do
  use :foo, :name => "hoge"
  use :bar, :suffix => "fuga"
  use :bar, :suffix => "moga"
  use :hoge
end

pipeline :hogefuga do
  retry_count 3

  use :foo, :name => "aaa"
  use :bar, :suffix => "bbb"
  use :hoge 
end

