# Generates a list of probabilities.
#
# To generate quartiles (1/4, 2/4, 3/4):
#     gen_probs(4)
#
def gen_probs(num, from=0, to=1)
  step = (to - from) / num.to_f
  ((from + step)...to).step(step).to_a
end

TERCILES = gen_probs(3)
QUARTILES = gen_probs(4)
DECILES = gen_probs(10)
CENTILES = gen_probs(100)

# Calculates weighted quantiles.
#
# The +data+ is a list of pairs of values and their corresponding weight:
#     [10, 4], [20, 3], [30, 2]
#
def wquantiles(data, probs=QUARTILES)
  grouped = data.group_by(&:first).map { |a, b| [a, b.reduce(0) { |sum, e| sum + e.last }] }
  values, weights = grouped.sort_by(&:first).transpose

  sum = 0
  cum_weights = weights.map { |e| sum += e }

  probs.map do |prob|
    h = 1 + (sum - 1) * prob
    mod = h % 1

    k1 = cum_weights.find_index { |e| e >= h.floor }
    k2 = cum_weights.find_index { |e| e >= h.ceil }

    (1 - mod) * values[k1] + (mod) * values[k2]
  end
end
